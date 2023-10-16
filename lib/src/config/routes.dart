import 'package:flutter/cupertino.dart';

import '../design/page/pdf_page.dart';

class Routes {
  static String
      pdf = '/pdf';


  static final Map<String, Widget Function(BuildContext)> pages = {
    Routes.pdf: (BuildContext context) => const PdfPage(),
  };
}
