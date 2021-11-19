
import 'package:doorstep_delivery/ui/utils/colors_and_icons.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ColumnBarChart extends StatefulWidget {

  const ColumnBarChart({ Key? key }) : super(key: key);

  @override
  _ColumnBarChartState createState() => _ColumnBarChartState();
}

class _ColumnBarChartState extends State<ColumnBarChart> {

  late TooltipBehavior _tooltipBehavior;
  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(
        enable: true,
        canShowMarker: false,
        duration: 2,
        format: ' sent: 100k\n received: 100k \n delivered: 100k',
        header: '');
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
     final List<ChartData> chartData = [
          ChartData('Mon', 12, 10, 14,),
          ChartData('Tue', 14, 11, 18, ),
          ChartData('Wed', 16, 10, 15, ),
          ChartData('Thurs', 17, 16, 18,),
          ChartData('Fri', 15, 18, 19, ),
          
        ];
    return 

     Container(
                    child: SfCartesianChart(
                        tooltipBehavior: _tooltipBehavior,
                        primaryXAxis: CategoryAxis(),
                        series: <ChartSeries>[
                            StackedColumnSeries<ChartData, String>(
                                groupName: 'Group A',
                                dataSource: chartData,
                                color:brightMainColor ,
                                xValueMapper: (ChartData sales, _) => sales.x,
                                yValueMapper: (ChartData sales, _) => sales.y1
                            ),
                            StackedColumnSeries<ChartData, String>(
                                groupName: 'Group B',
                                dataSource: chartData,
                                color: warmPrimaryColor,
                                xValueMapper: (ChartData sales, _) => sales.x,
                                yValueMapper: (ChartData sales, _) => sales.y2
                            ),
                            StackedColumnSeries<ChartData, String>(
                                groupName: 'Group c',
                                dataSource: chartData,
                                color: fadedHeadingsColor,
                                xValueMapper: (ChartData sales, _) => sales.x,
                                yValueMapper: (ChartData sales, _) => sales.y3
                            ),
                          
                        ]
                    )
                )   

;
  }
}


class ChartData{
        ChartData(this.x, this.y1, this.y2, this.y3, );
        final String x;
        final int y1;
        final int y2;
        final int y3;
       
    }





class StatisticsBarRoute extends StatefulWidget {
  
  final Color? lineColor;

  final barChartWidth;
  final barChartHeight;

  final barCharPlotAreaBackgroundColor;
  StatisticsBarRoute({this.lineColor = brightMainColor,this.barChartWidth,this.barChartHeight,this.barCharPlotAreaBackgroundColor});
  @override
  _StatisticsBarRouteState createState() => _StatisticsBarRouteState();
}

class _StatisticsBarRouteState extends State<StatisticsBarRoute> {
  
 
 late TooltipBehavior _tooltipBehavior;
  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(
        enable: true,
        canShowMarker: false,
        duration: 2,
        format: ' sent: 100k\n received: 100k \n delivered: 100k',
        header: '');
    super.initState();
  }

  
@override
    Widget build(BuildContext context) {
        final List<LineChartSalesData> chartData = [
            LineChartSalesData(DateTime.utc(2021,9,12),10),
            LineChartSalesData(DateTime.utc(2021,9,13), 1),
            LineChartSalesData(DateTime.utc(2021,9,14), 12),
            LineChartSalesData(DateTime.utc(2021,9,15), 13),
            LineChartSalesData(DateTime.utc(2021,9,16), 40),
             LineChartSalesData(DateTime.utc(2021,9,17),25),
            LineChartSalesData(DateTime.utc(2021,9,18), 16),
            LineChartSalesData(DateTime.utc(2021,9,19), 34),
            LineChartSalesData(DateTime.utc(2021,9,20), 18),
            LineChartSalesData(DateTime.utc(2021,9,21), 21),
             LineChartSalesData(DateTime.utc(2021,9,22),1),
            LineChartSalesData(DateTime.utc(2021,9,23), 10),
            LineChartSalesData(DateTime.utc(2021,9,24), 16),
            LineChartSalesData(DateTime.utc(2021,9,25), 32),
            LineChartSalesData(DateTime.utc(2021,9,26), 29)

        ];

        return Scaffold(
            body: Center(
                child: Container(
                    width: widget.barChartWidth,
                    height: widget.barChartHeight,
                    child: SfCartesianChart(
                      tooltipBehavior: _tooltipBehavior,
                       
                        primaryXAxis: DateTimeAxis(),
                        plotAreaBackgroundColor: widget.barCharPlotAreaBackgroundColor,
                        series: <ChartSeries>[
                          LineSeries<LineChartSalesData, DateTime>(
                               color: widget.lineColor,
                                dataSource: chartData,
                                xValueMapper: (LineChartSalesData sales, _) => sales.year,
                                yValueMapper: (LineChartSalesData sales, _) => sales.sales
                            )
                        ]
                    )
                )
            )
        );
    }

 
}

   class LineChartSalesData {
        LineChartSalesData(this.year, this.sales);
        final DateTime year;
        final double sales;
    }


