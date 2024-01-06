mkdir -p ./website/wslu/man/
wslu_ver="$(cat ./VERSION)"
if [ ! -d "./website/wslu/man/${wslu_ver}" ] ; then
    mkdir ./website/wslu/man/${wslu_ver}
    cp ./docs/*.html ./website/wslu/man/${wslu_ver}
    rm -f ./website/wslu/man/*.html
    for f in $(ls -d ./website/wslu/man/${wslu_ver}/*.html); do
        fname="${f##*/}"
        ln -s ./${wslu_ver}/${fname} ./website/wslu/man/${fname}
    done
fi
