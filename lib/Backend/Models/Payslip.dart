class Payslip {
  final int? id;
  final String title;
  final DateTime date;
  final double? amount;
  final bool? paid;
  final String url;

  Payslip(
      {this.id,
      required this.title,
      required this.date,
      this.amount,
      this.paid,
      required this.url});

  static List<Payslip> payslips = [
    Payslip(
        title: "1 - Rainbow",
        date: DateTime(2022, 6, 6),
        amount: 4000.00,
        paid: true,
        url:
            "https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf"),
    Payslip(
        title: "2 - Rainbow",
        date: DateTime(2022, 5, 5),
        amount: 4000.00,
        paid: true,
        url:
            "https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf"),
    Payslip(
        title: "3 - Rainbow",
        date: DateTime(2022, 4, 4),
        amount: 4000.00,
        paid: true,
        url:
            "https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf"),
    Payslip(
        title: "4 - Rainbow",
        date: DateTime(2022, 3, 3),
        amount: 4000.00,
        paid: true,
        url:
            "https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf"),
    Payslip(
        title: "5 - Rainbow",
        date: DateTime(2022, 2, 2),
        amount: 4000.00,
        paid: true,
        url:
            "https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf"),
    Payslip(
        title: "6 - Rainbow",
        date: DateTime(2022, 1, 1),
        amount: 4000.00,
        paid: true,
        url:
            "https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf"),
    Payslip(
        title: "7 - Rainbow",
        date: DateTime(2021, 12, 1),
        amount: 4000.00,
        paid: true,
        url:
            "https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf"),
    Payslip(
        title: "8 - Rainbow",
        date: DateTime(2021, 11, 1),
        amount: 4000.00,
        paid: true,
        url:
            "https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf"),
    Payslip(
        title: "9 - Rainbow",
        date: DateTime(2021, 10, 1),
        amount: 4000.00,
        paid: true,
        url:
            "https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf"),
    Payslip(
        title: "10 - Rainbow",
        date: DateTime(2021, 9, 1),
        amount: 4000.00,
        paid: true,
        url:
            "https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf"),
    Payslip(
        title: "11 - Rainbow",
        date: DateTime(2021, 8, 1),
        amount: 4000.00,
        paid: true,
        url:
            "https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf"),
    Payslip(
        title: "12 - Rainbow",
        date: DateTime(2021, 7, 1),
        amount: 4000.00,
        paid: true,
        url:
            "https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf"),
    Payslip(
        title: "13 - Rainbow",
        date: DateTime(2021, 6, 1),
        amount: 4000.00,
        paid: true,
        url:
            "https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf"),
    Payslip(
        title: "14 - Rainbow",
        date: DateTime(2021, 5, 1),
        amount: 4000.00,
        paid: true,
        url:
            "https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf"),
    Payslip(
        title: "15 - Rainbow",
        date: DateTime(2021, 4, 1),
        amount: 4000.00,
        paid: true,
        url:
            "https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf"),
    Payslip(
        title: "16 - Rainbow",
        date: DateTime(2021, 3, 1),
        amount: 4000.00,
        paid: true,
        url:
            "https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf"),
    Payslip(
        title: "17 - Rainbow",
        date: DateTime(2021, 2, 1),
        amount: 4000.00,
        paid: true,
        url:
            "https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf"),
    Payslip(
        title: "18 - Rainbow",
        date: DateTime(2021, 1, 1),
        amount: 4000.00,
        paid: true,
        url:
            "https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf"),
    Payslip(
        title: "19 - Rainbow",
        date: DateTime(2020, 12, 1),
        amount: 4000.00,
        paid: true,
        url:
            "https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf"),
    Payslip(
        title: "20 - Rainbow",
        date: DateTime(2020, 11, 1),
        amount: 4000.00,
        paid: true,
        url:
            "https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf"),
    Payslip(
        title: "21 - Rainbow",
        date: DateTime(2020, 10, 1),
        amount: 4000.00,
        paid: true,
        url:
            "https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf"),
    Payslip(
        title: "22 - Rainbow",
        date: DateTime(2020, 9, 1),
        amount: 4000.00,
        paid: true,
        url:
            "https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf"),
  ];
}
