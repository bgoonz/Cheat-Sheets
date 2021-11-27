#!/usr/bin/env python3
"""
http://cedeela.fr/~simon/files/print.py
"""

import cherrypy
import cups
import uuid
import tempfile

HTML_TEMPLATE = """
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html><head><title>Print</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head><body><h1>Print File</h1>
<form action="send" method="POST" enctype="multipart/form-data">
File name: <input name="file" type="file"><br>
User name: <input name="user"><br>
<input name="submit" type="submit">
</form>
</body>
</html>"""


class Print(object):
    @cherrypy.expose
    def index(self):
        return HTML_TEMPLATE

    @cherrypy.expose
    def send(self, file, user, **kwargs):
        try:
            cups.setUser(user)
            conn = cups.Connection()
            job_name = str(uuid.uuid4())
            content = file.file.read()
            with tempfile.NamedTemporaryFile(prefix="tmp_print") as f:
                f.write(content)
                f.flush()
                id = conn.printFile('MFP', f.name, job_name, {})
            msg = "success, job id: {}, job name: {}".format(id, job_name)
        except cups.IPPError as ex:
            status, description = ex
            msg = "IPP status is {}, meaning: {}".format(status, description)
        return msg


cherrypy.config.update({
    'server.socket_host': '0.0.0.0',
    'server.socket_port': 9999})
cherrypy.quickstart(Print())
