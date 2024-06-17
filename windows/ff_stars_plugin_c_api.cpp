#include "include/ff_stars/ff_stars_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "ff_stars_plugin.h"

void FfStarsPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  ff_stars::FfStarsPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
