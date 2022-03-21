#!/bin/bash
set -e

POSITIONAL_ARGS=()

INTL=false
intl_valid=false
while [[ $# -gt 0 ]]; do
  case $1 in
    -i|--intl)
      INTL="$2"
      shift # past argument
      shift # past value
      ;;
    -*|--*)
      echo "Unknown option $1"
      exit 1
      ;;
    *)
      POSITIONAL_ARGS+=("$1")
      shift # past argument
      ;;
  esac
done

set -- "${POSITIONAL_ARGS[@]}" # restore positional parameters

if [[ -n $1 ]]; then
    echo "Last line of file specified as non-opt/last argument:"
    exit 3
else
  case ${INTL} in
    true)
      echo "INTL marked as required"
      intl_valid=true
      ;;
    false)
      echo "INTL marked as not required"
      intl_valid=true
      ;;
    *)
      echo "INTL value is not valid. Marked by default as not required"
      ;;
  esac
fi

echo "1. Cleaning..."
flutter clean
echo "2. Getting dependencies"
flutter packages get
echo "3. Building auto generated files..."
flutter pub run build_runner build --delete-conflicting-outputs
# Avoid generation intl on each run. It will only run if -i, --intl param is set in true
step=4
if ${intl_valid}; then
  if ${INTL}; then
    echo "4. Generating INTL files..."
    flutter pub run intl_utils:generate
    step=5
  fi
fi
echo "$step. Analyzing..."
flutter analyze
((step++))
echo "$step. Testing..."
flutter test
((step++))
echo "$step. Validating formatting..."
dart format --set-exit-if-changed lib test

