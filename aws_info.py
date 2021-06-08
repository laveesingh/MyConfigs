#! /usr/bin/env python3
import sys
from pprint import pprint

import pytz
# from django.core.management import BaseCommand, CommandParser

import boto3
from argparse import ArgumentParser


class AmazonService:
    STAGING_CLUSTER = 'arn:aws:ecs:ap-southeast-1:941562457548:cluster/TripGuruStaging1'
    PROD_CLUSTER = 'arn:aws:ecs:ap-southeast-1:941562457548:cluster/TripGuruProduction'

    MENU = {
        1: 'ec2_info',
        2: 'ecs_deployments',
    }

    def __init__(self):
        self.parser = ArgumentParser(description='Add arguments')
        self.add_arguments()

    def add_arguments(self):

        self.parser.add_argument(
            '-o', '--option', type=int, choices=[0, 1, 2],
            help='option to execute; 0=render_menu, 1=ec2_info, 2=ecs_deployments'
        )
        self.parser.add_argument(
            '-ip', '--ip-address', type=int, choices=[1, 2],
            help='get ip addresses for either prod (option 1) or staging (option 2)'
        )

    def handle(self, **options):
        default_option = options.get('option', 0)
        ip_arg = options.get('ip_address')
        try:
            while True:
                if ip_arg is not None:
                    self.render_ip_addresses(ip_arg)
                    return

                if default_option is not None:
                    option = default_option
                else:
                    option = self.render_menu()
                if option == 0:
                    option = self.render_menu()
                if option == 1:
                    self.render_ec2_info()
                elif option == 2:
                    self.ecs_deployments()
                else:
                    print("Try again")
                if default_option:
                    break
        except KeyboardInterrupt:
            sys.exit(0)

    def render_menu(self):
        for key, value in self.MENU.items():
            print(f'{key}: {value}')
        option = input("Enter option number: ")
        return int(option)

    @staticmethod
    def get_ec2_instances():
        ec2 = boto3.resource('ec2')
        running_instances = ec2.instances.filter(Filters=[{
            'Name': 'instance-state-name',
            'Values': ['running'],
        }])
        instances = []
        for instance in running_instances:
            name = None
            for tag in instance.tags:
                if 'Name' in tag['Key']: name = tag['Value']
            instances.append({
                'Name': name,
                'Type': instance.instance_type,
                'State': instance.state['Name'],
                'Public IP': instance.public_ip_address,
            })
        instances = sorted(instances, key=lambda item: item['Name'])
        return instances

    def render_ec2_info(self, **options):
        instances = self.get_ec2_instances()
        for item in instances:
            for key, value in item.items(): print(key.ljust(60), end='')
            print('')
            break
        for item in instances:
            print('-' * 200)
            for key, value in item.items(): print(value.ljust(60), end='')
            print('')

    def render_ip_addresses(self, ip_arg):
        """
        ip_arg is either 1 (for prod) or 2 (for staging)
        """
        instances = self.get_ec2_instances()
        for instance in instances:
            if ip_arg == 1 and 'production' in instance['Name'].lower():
                print(instance['Public IP'])
            elif ip_arg == 2 and 'staging' in instance['Name'].lower():
                print(instance['Public IP'])

    def ecs_deployments(self, **options):
        ecs = boto3.client('ecs')

        prod_services = ecs.list_services(cluster=self.PROD_CLUSTER)
        staging_services = ecs.list_services(cluster=self.STAGING_CLUSTER)
        services_described = ecs.describe_services(
            cluster=self.PROD_CLUSTER, services=prod_services.get('serviceArns')).get('services') + ecs.describe_services(
            cluster=self.STAGING_CLUSTER, services=staging_services.get('serviceArns')).get('services')

        def detail_service(serv):
            def local_time(ts):
                local = pytz.timezone('Asia/Kolkata')
                return ts.astimezone(local).strftime('%d/%m/%Y %H:%M:%S')

            def detail_deployment(dep):
                return f'[{local_time(dep.get("createdAt"))}]  RunningCount: {dep.get("runningCount")}, ' \
                       f'PendingCount: {dep.get("pendingCount")}, Status: {dep.get("status")}, ' \
                       f'TaskDefinition: {dep.get("taskDefinition")}'

            def detail_event(evt):
                return f'[{local_time(evt.get("createdAt"))}]  {evt.get("message")}'

            deployments = serv.get('deployments')
            events = serv.get('events')[:10]

            det = f' Service: {serv.get("serviceName")} '.center(200, '#')
            det += f'\n\tStatus: {serv.get("status")}, RunningCount: {serv.get("runningCount")}, ' \
                   f'PendingCount: {serv.get("pendingCount")}\n'
            det += '\nDeployments:\n'
            for deployment in deployments:
                det += f'\t{detail_deployment(deployment)}\n'
            det += '\nEvents:\n'
            for event in events:
                det += f'\t{detail_event(event)}\n'
            return det

        for service in services_described:
            detail = detail_service(service)
            print(detail)


if __name__ == '__main__':
    inst = AmazonService()
    options = vars(inst.parser.parse_args())
    inst.handle(**options)
