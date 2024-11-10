import 'package:airmid/src/provider/bolc/patient_summry/bloc/biling_details_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BilingDetails extends StatefulWidget {
  final int billNo;
  const BilingDetails({super.key, required this.billNo});

  @override
  State<BilingDetails> createState() => _BilingDetailsState();
}

class _BilingDetailsState extends State<BilingDetails> {
  final BilingDetailsBloc _bilingDetailsBloc = BilingDetailsBloc();
  @override
  void initState() {
    _bilingDetailsBloc.add(BilingDetailsEvent.started(widget.billNo));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _bilingDetailsBloc,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          surfaceTintColor: Colors.indigo,
          foregroundColor: Colors.indigo,
          shadowColor: Colors.indigo,
          backgroundColor: Colors.indigo,
          centerTitle: false,
          leading: BackButton(color: Colors.white),
          title: Text(
            "Biling Details",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        body: BlocBuilder<BilingDetailsBloc, BilingDetailsState>(
          builder: (context, state) {
            return state.when(
              initial: () => SizedBox.shrink(),
              loading: () =>
                  Center(child: CircularProgressIndicator.adaptive()),
              success: (bilingDetails) {
                return ListView.builder(
                  itemCount: bilingDetails.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 8.0)
                          .r,
                      child: Card(
                        color: Colors.white,
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (bilingDetails[index].serviceName != null) ...[
                                _buildDetailRow(
                                  icon: Icons.medical_services,
                                  label: 'Service Name:',
                                  value: bilingDetails[index].serviceName ?? "",
                                ),
                              ],
                              if (bilingDetails[index].price != null) ...[
                                _buildDetailRow(
                                  icon: Icons.attach_money,
                                  label: 'Price:',
                                  value: '₹ ${bilingDetails[index].price}',
                                ),
                              ],
                              if (bilingDetails[index].qty != null) ...[
                                _buildDetailRow(
                                  icon: Icons.format_list_numbered,
                                  label: 'Quantity:',
                                  value: bilingDetails[index].qty.toString(),
                                ),
                              ],
                              if (bilingDetails[index].totalAmt != null &&
                                  bilingDetails[index].netAmount != null) ...[
                                Divider(),
                              ],
                              if (bilingDetails[index].totalAmt != null) ...[
                                _buildDetailRow(
                                  icon: Icons.money,
                                  label: 'Total Amount:',
                                  value: '₹ ${bilingDetails[index].totalAmt}',
                                ),
                              ],
                              if (bilingDetails[index].netAmount != null) ...[
                                _buildDetailRow(
                                  icon: Icons.money_off,
                                  label: 'Net Amount:',
                                  value: '${bilingDetails[index].netAmount}',
                                ),
                              ],
                              if (bilingDetails[index].doctorName != null) ...[
                                Divider(),
                                _buildDetailRow(
                                  icon: Icons.person,
                                  label: 'Doctor Name:',
                                  value: bilingDetails[index].doctorName ?? '',
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
              error: (message) {
                return Center(
                  child: Text(message),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

Widget _buildDetailRow(
    {required IconData icon, required String label, required String value}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Row(
      children: [
        Icon(icon, color: Colors.blueAccent),
        SizedBox(width: 16),
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Text(value),
      ],
    ),
  );
}
