#import json
from fake_logs.fake_logs import FakeLogs


def handler(event, context):
    """
    Main entry point of the Lambda function.

    :param event:
    Request JSON
    {
       "file_format": "log file format",
       "num_lines": "number of log lines to generate",
    }
    :param context:
    :return:
    Response JSON format

    {
    NULL
    }

    """

    FakeLogs(
        #        filename=args.output,
        num_lines=event.get("num_lines"),
        #        sleep=args.sleep,
        #        line_pattern=line_pattern,
        file_format=event.get("file_format")).run()
