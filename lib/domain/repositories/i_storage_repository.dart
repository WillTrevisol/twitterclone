import 'dart:io';

import 'package:twitterclone/data/core/typedef.dart';

abstract class IStorageRepository {

  FutureEither<List<String>> storeImages(List<File> images); 

}