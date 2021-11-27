#! /usr/bin/env python3
# -*- coding: utf8 -*-
"""
Script to read and fix a Jupyter notebook produced by the OCaml kernel.

- It duplicates the output cells of type 'execute_result' as 'stream' cells on the 'stderr' stream (fixes conversion to PDF with jupyter-nbconvert)
- Use it like this:
$ fix-iocaml-notebook-exports-to-pdf.py Old_notebook.ipynb New_notebook.ipynb

About:
- *Date:* 07/09/2017.
- *Author:* Lilian Besson, (C) 2017
- *Licence:* MIT Licence (http://lbesson.mit-license.org).
- *Web*: https://github.com/Naereen/fix-iocaml-notebook-exports-to-pdf
"""

import sys
import os
import shutil
import json
import nbformat
from pprint import pprint


def is_stderr_used(outputs):
    for output in outputs:
        try:
            if output['name'] == "stderr":
                return True
        except KeyError:
            pass
    return False


def transform_data_texthtml(data_texthtml):
    data_texthtml[0] = data_texthtml[0][2:]
    for i in range(len(data_texthtml)):
        # Hack to replace a few HTML escaped caracters
        data_texthtml[i] = data_texthtml[i].replace('&gt;','>').replace('&lt;','<').replace('&quot;','\'')
    return data_texthtml


def get_data_texthtml(outputs):
    data_texthtml = []
    for output in outputs:
        try:
            if output['output_type'] == "execute_result" and 'text/html' in output['data']:
                long_data_texthtml = output['data']['text/html']
                assert len(long_data_texthtml) >= 8
                data_texthtml += transform_data_texthtml(long_data_texthtml[6:-1])
        except KeyError:
            pass
    return data_texthtml


def main(old, new, debug=False):
    filename = old
    assert filename[-6:] == '.ipynb', "Error: the input file is not a .ipynb Jupyter Notebook file."
    with open(filename, 'r') as file:
        content = json.load(file)
    # Check that it is a IOCaml notebook
    assert content['metadata']['kernelspec']['name'] == "iocaml-kernel" and content['metadata']['kernelspec']['language'] == "ocaml" and content['metadata']['kernelspec']['display_name'] == "OCaml", "Error: the input notebook does not appear to have been produced by the IOCaml OCaml kernel."
    # For each cell
    for cell in content['cells']:
        if cell['cell_type'] == "code":
            outputs = cell['outputs']
            # execution_count = cell['execution_count']
            # No need
            # if is_stderr_used(outputs):
            #     break
            data_texthtml = get_data_texthtml(outputs)
            # new_stderr_output = {
            #     "name": "stderr",
            #     "output_type": "stream",
            #     "text": data_texthtml,
            #     # "execution_count": execution_count,
            #     # "metadata": {}
            # }
            # if debug: pprint(new_stderr_output)
            # cell['outputs'].append(new_stderr_output)
            for output in outputs:
                if 'data' in output:
                    output['data']['text/plain'] = data_texthtml
                    if debug: pprint(output['data'])
                    break  # do not add twice the same output cell

    # Check before changing the file
    nbformat.validate(content)  # raise an Error if not valid notebook

    # Backup the input file by moving it to $input.ipynb~
    # shutil.copy(filename, filename.replace('.ipynb', '.ipynb~'))

    # Now write the JSON to the input file $input.ipynb
    with open(new, 'w') as file:
        json.dump(content, file, indent=2)
    print("New notebook written to", new)


if __name__ == '__main__':
    argv = sys.argv[1:]
    old = argv[0]
    if len(argv) < 2:
        new = old.replace('.ipynb', '__fix-iocaml-notebook-exports-to-pdf.ipynb')
    else:
        new = argv[1]
    print("old =", old)
    print("new =", new)
    main(old, new)
