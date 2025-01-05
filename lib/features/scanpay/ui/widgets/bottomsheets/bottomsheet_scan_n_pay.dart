import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../widgets/bottomsheet/bottomsheet_scaffold.dart';
import '../../../store/models/model_upi_data.dart';
import '../../../store/scanpay_store.dart';
import '../../pages/scan_pay_page.dart';

Future showScanNPayBottomSheet(
  BuildContext context,
  UpiDataModel upiData,
) async {
  final theme = Theme.of(context);
  final store = Provider.of<ScanpayStore>(context, listen: false)..clearData();

  // Getting data from the services
  final listOfPayUsing = store.getPayUsing();

  await showScaffoldBottomsheet(
    context,
    child: ScanNPayPage(
      theme: theme,
      store: store,
      upiDataModel: upiData,
      listOfPayUsing: listOfPayUsing,
    ),
  );
}
