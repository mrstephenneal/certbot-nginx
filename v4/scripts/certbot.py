import os
import shutil
from argparse import ArgumentParser
from requests import get


def console_sep(char='- ', length=40):
    """Return a separator line to the console output."""
    return ''.join([char * length])


def letsencrypt_cert_cleaner(domain, root='/etc/letsencrypt/', paths=('live', 'archive', 'renewal')):
    """Remove Letsencrypt directories that contain dummy certs and .conf's."""
    domain = domain.strip()
    for path in (os.path.join(root, p) for p in paths):
        # Renewal conf's
        if path.endswith('renewal'):
            removal = os.path.join(path, domain + '.conf')

        # Live & archive certs
        else:
            removal = os.path.join(path, domain)

        # Delete file/directory
        status = 'Success'
        try:
            os.remove(removal)
        except IsADirectoryError:
            shutil.rmtree(removal)
        except FileNotFoundError:
            status = 'Skipped' if not os.path.exists(removal) else 'Error'
        print('{0} deleting: {1}'.format(status, removal))


def main():
    # Declare argparse argument descriptions
    usage = 'AWS S3 command-line-interface wrapper.'
    description = 'Execute AWS S3 commands.'
    helpers = {
        'domain': "List of domain names separated by spaces.",
        'email': "Letsencrypt account email address.",
        'staging': "Enable/disable staging environment for dev configs.",
        'validation-domain': "SSL validation server domain.",
    }

    # construct the argument parse and parse the arguments
    parser = ArgumentParser(usage=usage, description=description)
    parser.add_argument('--domains', help=helpers['domain'], type=str)
    parser.add_argument('--email', help=helpers['email'], type=str)
    parser.add_argument('--staging', help=helpers['staging'], type=int, default=1)
    parser.add_argument('--validation-domain', help=helpers['validation-domain'], type=str)

    # Parse Arguments
    args = vars(parser.parse_args())
    args['domains'] = args['domains'].split(' ')

    # Send request to validation server
    for domain in args['domains']:
        print('### Sending cert request for domain {} to the validation server...'.format(domain))
        response = get('http://' + args['validation_domain'] + '/cert', data={'domain': domain,
                                                                              'email': args['email'],
                                                                              'staging': args['staging']})
        print('\n'.join(response.json()['output']))
        print('### Received response to cert request for domain {} from the validation server...'.format(domain))
    print(console_sep())


if __name__ == '__main__':
    main()
