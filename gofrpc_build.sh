#!/bin/sh

[ $# -lt 1 ] && {
    echo "usage: $0 arch";
    echo -e "\tsupport list: monaco rtd1296 apollolake";
    #exit 1;
}

SCRIPTPATH="${0%/*}"
cd ${SCRIPTPATH}
CURPATH="$(pwd)"

APPNAME="gofrpc"

PLATVER="7.0"
PLATFORM="${1:-apollolake}"

### 实际编译环境 工程目录
APPBUILDPATH="${CURPATH}/build_env/ds.${PLATFORM}-${PLATVER}/source"
[ -d "${APPBUILDPATH}" ] || { echo "invalid arch:${PLATFORM}"; exit 2; }
REALBUILDPATH="${APPBUILDPATH}/${APPNAME}"
mkdir -p ${REALBUILDPATH} 2>/dev/null

### 可见编译环境 工程目录
APPSRCPATH="${CURPATH}/source"
PROJTEMPLATE="${APPNAME}"

### 编译脚本
BUILDTOOLPATH="${CURPATH}/pkgscripts-ng"

### 编译输出
BUILDOUTPATH="${CURPATH}/build_env/ds.${PLATFORM}-${PLATVER}/image/packages"

## 工程拷贝
rm -rf ${REALBUILDPATH}/*
#cp -rf ${APPSRCPATH}/gofrpc_bin/${PLATFORM}/frpc ${APPSRCPATH}/${PROJTEMPLATE}/bin/
#cp -rf ${APPSRCPATH}/gofrpc_bin/${PLATFORM}/frpc.ini ${APPSRCPATH}/${PROJTEMPLATE}/bin/

## build
rm -rf ${BUILDOUTPATH}/${APPNAME}*.spk
cd ${BUILDTOOLPATH}
./PkgCreate.py -v ${PLATVER} -p apollolake -c ${APPNAME} #--print-log

# list
ls -lhrt ${BUILDOUTPATH}/
