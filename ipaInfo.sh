#! /usr/bin/bash

if [[ ! $1 ]]; then
	echo '脚本执行缺少参数! eg: bash /path/script.sh /paht/xxx.ipa '
	exit 0
fi

ipaPath=$(dirname $1)

echo ${ipaPath}

unzipPath=~/Desktop/ipaInfo/

unzip $1 -d ${unzipPath}

if [[ ! $? == 0 ]]; then
	echo "$1 解压失败！"
	rm -rf ${unzipPath}
	exit 0
fi

cd ${unzipPath}/Payload/*.app

plistPath=~/Desktop/ipaInfo.plist

security cms -D -i embedded.mobileprovision > ${plistPath}

if [[ ! $? == 0 ]]; then
	echo "获取$1信息失败！"
	rm -rf ${unzipPath}
	rm ${plistPath}
	exit 0
fi

rm -rf ${unzipPath}

open ~/Desktop/ipaInfo.plist