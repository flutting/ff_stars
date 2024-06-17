#ifndef FLUTTER_PLUGIN_FF_STARS_PLUGIN_H_
#define FLUTTER_PLUGIN_FF_STARS_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace ff_stars {

class FfStarsPlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  FfStarsPlugin();

  virtual ~FfStarsPlugin();

  // Disallow copy and assign.
  FfStarsPlugin(const FfStarsPlugin&) = delete;
  FfStarsPlugin& operator=(const FfStarsPlugin&) = delete;

  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

}  // namespace ff_stars

#endif  // FLUTTER_PLUGIN_FF_STARS_PLUGIN_H_
