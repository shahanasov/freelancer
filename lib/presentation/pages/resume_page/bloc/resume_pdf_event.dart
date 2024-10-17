part of 'resume_pdf_bloc.dart';

 class ResumePdfEvent {}
 class ResumePdfFetch extends ResumePdfEvent{
  final String userId;

  ResumePdfFetch({required this.userId});
 }
