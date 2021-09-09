
import logging
import logging.handlers
import sys
class Logger:

    def __init__(self, f, console=False, maxBytes=100000000, backupCount=1000):
        self.f = f
        self.logger = None
        self.setup(console, maxBytes, backupCount)

    def setup(self, console, maxBytes, backupCount):
        try:
            # setup the logger
            self.logger = logging.getLogger()
            self.logger.setLevel(logging.INFO)
            handler = logging.handlers.RotatingFileHandler(
                self.f, maxBytes=maxBytes, backupCount=backupCount)
            formatter = logging.Formatter("%(asctime)s-%(levelname)s - %(message)s")
            handler.setFormatter(formatter)
            self.logger.addHandler(handler)
            if console: self.logger.addHandler(logging.StreamHandler(sys.stdout))
        except Exception as err:
            raise LoggerException(err)

class LoggerException(Exception):
    pass



#from logger import Logger, LoggerException
import argparse
import csv

def parse_inputs():
    parser = argparse.ArgumentParser(
        description = __doc__,
        formatter_class = argparse.RawDescriptionHelpFormatter,
    )
    parser.add_argument('-i', '--input-file', help='Input file',
            metavar='FILE', default=None)
    parser.add_argument('-o', '--output-file', help='Output file',
            metavar='FILE', default=None)
    parser.add_argument('-l', '--log-file', help='Log file',
            metavar='FILE', default=None)
    arguments = vars(parser.parse_args())
    return arguments

def main(input_file, output_path):
    try:
        _logger.info('Start ingesting file')
        with open(input_file, 'r', encoding = 'utf-8') as source:
            reader = csv.reader(source)
            with open(output_file,'w', encoding = 'utf-8') as result:
                writer = csv.writer(result)
                for r in reader:
                    writer.writerow((r[0],r[1],r[2],r[3]))
        _logger.info('Output file: {}'.format(output_file))
    except Exception as e:
        _logger.error('Error in removing file column: {}'.format(str(e)))


if __name__ == "__main__":
    args = parse_inputs()
    input_file = args['input_file'] 
    output_file = args['output_file']
    logname = args['log_file']
    try:
        _logger = Logger(logname, True).logger
        _logger.info('Start delete column')
        main(input_file, output_file)
        _logger.info('Column deleted')
    except Exception as e:
        _logger.error('Error in removing file column: {}'.format(str(e)))