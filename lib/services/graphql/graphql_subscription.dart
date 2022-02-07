// import 'dart:async';
//
// import 'package:flutter/material.dart';
// import 'package:graphql_flutter/graphql_flutter.dart';
//
// import '../spref_core.dart';
// import 'graphql_client.dart';
//
// typedef Builder<QueryResult> = Widget Function(QueryResult result);
//
// class GraphqlSubscription extends StatefulWidget {
//   final Builder<QueryResult> builder;
//   final String? document;
//
//   GraphqlSubscription({Key? key, required this.builder, this.document}) : super(key: key);
//
//   @override
//   State<GraphqlSubscription> createState() => _GraphqlSubscriptionState();
// }
//
// class _GraphqlSubscriptionState extends State<GraphqlSubscription> {
//   Stream<QueryResult>? stream;
//   late SubscriptionOptions option;
//   var subscriptionDocument = gql(r'''
//         subscription{
//             threadStream{
//               thread{
//                 id
//               }
//               message{
//                 id
//               }
//             }
//           }
//   ''');
//
//
//   void _initSubscription() {
//     stream = graphqlClient.subscribe(option);
//   }
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     if(widget.document!=null){
//       subscriptionDocument=gql(widget.document!);
//     }
//     option = SubscriptionOptions(
//       document: subscriptionDocument,
//     );
//     _initSubscription();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<QueryResult>(
//       stream: stream,
//       initialData: QueryResult.optimistic(
//         data: option.optimisticResult as Map<String, dynamic>?,
//       ),
//       builder: (context, snapshot) {
//         return widget.builder(snapshot.data!);
//       },
//     );
//   }
// }
