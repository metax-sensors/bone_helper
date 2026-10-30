include(CPM)
CPMAddPackage(
  NAME sol2
  VERSION 3.5.0
  URL https://github.com/ThePhD/sol2/archive/refs/tags/v3.5.0.tar.gz
  URL_HASH SHA256=86c0f6d2836b184a250fc2907091c076bf53c9603dd291eaebade36cc342e13c
  # fixes std::map container iteration with GCC >= 14, see https://github.com/ThePhD/sol2/pull/1676
  PATCHES "${CMAKE_CURRENT_LIST_DIR}/sol2-usertype-container-sen.patch"
)
