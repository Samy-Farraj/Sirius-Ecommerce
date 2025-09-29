import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sirius/app/features/branches/domain/entities/branch.dart' as br;
import 'package:sirius/app/features/product/data/models/NewProductParameter.dart';
import 'package:sirius/app/features/product/presentation/pages/add_product_step_tow_screen.dart';
import '../../../../../../../src/components/svg_icon_widget.dart';
import '../../../../../../../src/themes/app_theme.dart';
import '../../../../../my_profile/presentation/bloc/my_profile_bloc.dart';

class BranchCard extends StatelessWidget {
  final Branch branch;
  final int index;
  final Function(int) onRemove;
  List<br.Branch>? branches;
  MyProfileBloc profileBloc;
  BranchCard({
    Key? key,
    required this.branch,
    required this.branches,
    required this.profileBloc,
    required this.index,
    required this.onRemove,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final branchEntity = branches!.firstWhere(
      (b) => b.id == branch.branchId,
      orElse: () =>
          br.Branch(id: branch.branchId, title: 'Branch ${branch.branchId}'),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              branchEntity.title ?? 'branch'.tr(),
              style:
                  textTheme.titleSmall!.copyWith(fontWeight: FontWeight.w400),
            ),
            IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: () => onRemove(index),
            ),
          ],
        ),
      ],
    );
  }
}
