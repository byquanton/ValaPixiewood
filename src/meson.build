valapixiewood_sources = [
  'main.vala',
  'application.vala',
  'window.vala',
]

valapixiewood_deps = [
  config_dep,
  dependency('gtk4'),
  dependency('libadwaita-1', version: '>= 1.4'),
]

valapixiewood_sources += gnome.compile_resources('valapixiewood-resources',
  'valapixiewood.gresource.xml',
  c_name: 'valapixiewood'
)

executable('valapixiewood', valapixiewood_sources,
  dependencies: valapixiewood_deps,
  include_directories: config_inc,
  android_exe_type: 'application',
       install: true,
)
