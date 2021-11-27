#! /usr/local/bin/scrapy runspider
# -*- coding: utf-8; mode: python -*-
""" A small scrapper (using Scrapy) to extract URL of some songs in my YouTube "Watch Later" playlist.

- *Reference:* https://doc.scrapy.org/
- *Date:* 01/04/2017.
- *Author:* Lilian Besson © 2017.
- *Licence:* MIT Licence (http://lbesson.mit-license.org).
"""

from __future__ import print_function  # Python 2 compatibility if needed

import logging
import scrapy

# Trying to disable logging
logging.getLogger('scrapy').setLevel(logging.WARNING)
logging.getLogger('scrapy').propagate = False
logging.getLogger('scrapy.utils').propagate = False


class QuotesSpider(scrapy.Spider):
    """Small scrapy Spider."""
    name = "Watch Later"
    start_urls = [
        'file:///tmp/wl.html'
    ]
    custom_settings = {
    	"LOG_ENABLED": False,
    	"LOG_LEVEL": 'ERROR',
    }

    def parse(self, response):
        """Parse the response to print a JSON file of all videos in /tmp/wl.html"""
        i = 0
        for item in response.css('td.pl-video-title'):
            i += 1  # enumerate(...) was not working!
            video = item.css('a.pl-video-title-link')[0]
            author = item.css('div.pl-video-owner')[0]
            res = {
                'id': i,
                'href': video.xpath('@href').extract_first().replace('&index=%i&list=WL'%i, ''),
                'title': video.css('a::text').extract_first().strip(),
                'author': author.css('a::text').extract_first().strip()
            }
            print(res)
            #yield res


# End of youtube_playlist_spider_scrapy.py
