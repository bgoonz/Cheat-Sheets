#!/usr/bin/env python
#-*- coding: utf-8 -*-

# Configure your logger.
import logging, coloredlogs
logger = logging.getLogger('your-module')
logger.addHandler(coloredlogs.ColoredStreamHandler())

# Some examples.
logger.setLevel(logging.DEBUG)
logger.debug("this is a debugging message")
logger.info("this is an informational message")
logger.warn("this is a warning message")
logger.error("this is an error message")
logger.fatal("this is a fatal message")
logger.critical("this is a critical message")
