## Installation

> CAUTION: please remove the old packages if you have installed, they will damage your manpage folder!

To install, just run the following command in the bash prompt:

`curl -o- https://raw.githubusercontent.com/patrick330602/wslu/master/install.sh | bash`

This will install to the folder `.wslu` under your home.

To install manually, run the following command:

```bash
git clone https://github.com/patrick330602/wslu.git
# or git clone https://github.com/patrick330602/wslu.git <destination> for your preferred destination
cd /path/to/wslu/folder
./configure -i
```

## Remove & Reinstall

- run `wsluconfig -u` will remove the link from the system but not the source folder. You can install it again by entering `wsluconfig -i`;
- run `wsluconfig -p` will remove everything installed;
- if there is something run, run `wsluconfig -r` to reinstall.
