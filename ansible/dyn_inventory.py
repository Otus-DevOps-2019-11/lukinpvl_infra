#!/usr/bin/env python

import argparse
import googleapiclient.discovery
from six.moves import input
import warnings
warnings.filterwarnings("ignore", "Your application has authenticated using end user credentials")


# [START list_instances]
def list_instances(compute, project, zone):
    result = compute.instances().list(project=project, zone=zone).execute()
    return result['items'] if 'items' in result else None
# [END list_instances]


# [START run]
def main(project, zone, instance_name, list, wait=True):
    compute = googleapiclient.discovery.build('compute', 'v1')
    if list:
        instances = list_instances(compute, project, zone)
        print('{"app":{"hosts":')
        i = 0
        for instance in instances:
          if 'app' in instance['name']:
            i += 1
            if 'accessConfigs' in instance['networkInterfaces'][0]:
               if 'natIP' in instance['networkInterfaces'][0]['accessConfigs'][0]:
                 if i > 1:
                   print(',["' + instance['networkInterfaces'][0]['accessConfigs'][0]['natIP'] + '"]')
                 else:
                   print('["' + instance['networkInterfaces'][0]['accessConfigs'][0]['natIP'] + '"]')
        print('},"db":{"hosts":')
        i = 0
        for instance in instances:
          if 'db' in instance['name']:
            i += 1
            if 'accessConfigs' in instance['networkInterfaces'][0]:
               if 'natIP' in instance['networkInterfaces'][0]['accessConfigs'][0]:
                 if i > 1:
                   print(',["' + instance['networkInterfaces'][0]['accessConfigs'][0]['natIP'] + '"]')
                 else:
                   print('["' + instance['networkInterfaces'][0]['accessConfigs'][0]['natIP'] + '"]')
        print('}}')

if __name__ == '__main__':
    parser = argparse.ArgumentParser(
        description=__doc__,
        formatter_class=argparse.RawDescriptionHelpFormatter)
    parser.add_argument(
        '--project_id',
        default='infra-262810',
        help='Your Google Cloud project ID.')
    parser.add_argument(
        '--zone',
        default='europe-west1-b',
        help='Compute Engine zone to deploy to.')
    parser.add_argument(
        '--name', default='demo-instance', help='New instance name.')
    parser.add_argument(
        '--list', '-l', action='store_true')

    args = parser.parse_args()

    main(args.project_id, args.zone, args.name, args.list)
# [END run]
