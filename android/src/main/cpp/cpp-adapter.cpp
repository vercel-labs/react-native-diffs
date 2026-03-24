#include <jni.h>
#include "diffsOnLoad.hpp"

JNIEXPORT jint JNICALL JNI_OnLoad(JavaVM* vm, void*) {
  return margelo::nitro::diffs::initialize(vm);
}
