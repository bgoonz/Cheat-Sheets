#!/usr/bin/env bash
echo -e "Difference between ~/ownCloud/cloud.openmailbox.org/TODO.rst and ~/TODO.rst :"
ls -larth ~/TODO.rst
file ~/ownCloud/cloud.openmailbox.org/TODO.rst
diff ~/ownCloud/cloud.openmailbox.org/TODO.rst ~/TODO.rst
echo "OK to use the one from ownCloud? [Enter]"
read || exit

echo -e "Synchronizing ~/TODO.rst..."
mv -vf ~/TODO.rst /tmp/
ln ~/ownCloud/cloud.openmailbox.org/TODO.rst ~/
echo -e "Synchronization for ~/TODO.rst done."
ls -larth ~/TODO.rst
file ~/TODO.rst
