#!/bin/sh
############ Setup iOS Universal Build ############


DEBUG="false"

if [ $DEBUG = "true" ]
then
echo "########### TESTS #############"
echo "Use the following variables when debugging this script; note that they may change on recursions"
echo "BUILD_DIR = $BUILD_DIR"
echo "BUILD_ROOT = $BUILD_ROOT"
echo "CONFIGURATION_BUILD_DIR = $CONFIGURATION_BUILD_DIR"
echo "BUILT_PRODUCTS_DIR = $BUILT_PRODUCTS_DIR"
echo "CONFIGURATION_TEMP_DIR = $CONFIGURATION_TEMP_DIR"
echo "TARGET_BUILD_DIR = $TARGET_BUILD_DIR"
echo "PLATFORM_NAME = $PLATFORM_NAME"
echo "SDK_NAME = $SDK_NAME"
echo "########### /TEST #############"
fi

SDK_VERSION=$(echo ${SDK_NAME} | grep -o '.\{3\}$')

echo "SDK VERSION = $SDK_VERSION"


if [ ${PLATFORM_NAME} = "iphonesimulator" ] 
then
OTHER_BUILD_SDK=iphoneos${SDK_VERSION}
else
OTHER_BUILD_SDK=iphonesimulator${SDK_VERSION}
fi

echo "XCode set to build for ${PLATFORM_NAME} with SDK ${SDK_VERSION} and deployment target ${IPHONEOS_DEPLOYMENT_TARGET}"
echo "We will also build for ${OTHER_BUILD_SDK}"


############### Build For Missing Target ###############

if [ "true" == ${ALREADYINVOKED:-false} ]
then
echo "RECUSION: I am NOT the root invocation so I'm not going to recurse"
else
export ALREADYINVOKED="true"

ACTION="build"

echo "RECURSION: I AM THE ROOM... recursing all missing build targets NOW..."
echo "RECURSION: ...about to invoke: xcodebuild -configuration \"${CONFIGURATION}\" -target \"${TARGET_NAME}\" -sdk \"${OTHER_BUILD_SDK}\" ${ACTION} RUN_CLANG_STATIC_ANALYZER=NO"

xcodebuild -project "${PROJECT_FILE_PATH}" -configuration "${CONFIGURATION}" -target "${TARGET_NAME}" -sdk "${OTHER_BUILD_SDK}" ${ACTION} RUN_CLANG_STATYC_ANALYZER=NO BUILD_DIR="${BUILD_DIR}" BUILD_ROOT="${BUILD_ROOT}"


# Merge Simulator and Device builds into one fat binary for each configuration
CURRENTCONFIG_DEVICE_DIR=${SYMROOT}/${CONFIGURATION}-iphoneos
CURRENTCONFIG_SIMULATOR_DIR=${SYMROOT}/${CONFIGURATION}-iphonesimulator

echo "Taking devive build from: ${CURRENTCONFIG_DEVICE_DIR}"
echo "Taking simulator build from: ${CURRENTCONFIG_SIMULATOR_DIR}"

UNIVERSAL_BUILD_DIR=${SYMROOT}/${CONFIGURATION}-univeral-ios
echo "Universal build will go to: ${UNIVERSAL_BUILD_DIR}"

mkdir -p ${UNIVERSAL_BUILD_DIR}
rm -rf "${UNIVERSAL_BUILD_DIR}/${EXECUTABLE_NAME}"

echo "lipo: for current configuration (${CONFIGURATION}) creating output file ${UNIVERSAL_BUILD_DIR}/${EXECUTABLE_NAME}"
lipo -create -output "${UNIVERSAL_BUILD_DIR}/${EXECUTABLE_NAME}" "${CURRENTCONFIG_DEVICE_DIR}/${EXECUTABLE_NAME}" "${CURRENTCONFIG_SIMULATOR_DIR}/${EXECUTABLE_NAME}"

fi

