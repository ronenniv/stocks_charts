import 'package:stocks_charts/models/list_stock_data_series.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:stocks_charts/models/stock_data_series.dart';
import 'package:flutter/material.dart';

class StockLineChart extends StatelessWidget {
  const StockLineChart({
    Key key,
    @required this.stockDataSeries,
    @required this.flagLandscape,
  }) : super(key: key);

  static const yAxisCostName = 'Cost';
  static const yAxisCostTitleName = 'Closing Cost';
  static const yAxisVolumeName = 'Volume';
  static const yAxisVolumeTitleName = 'Total Volumne';
  static const xAxisName = 'Date';
  static const xAxisTitleName = 'Date';

  final bool flagLandscape;
  final ListStockDataSeries stockDataSeries;

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      primaryXAxis: CategoryAxis(
        name: xAxisName,
        title: flagLandscape ? null : AxisTitle(text: xAxisTitleName),
      ),
      primaryYAxis: NumericAxis(
        opposedPosition: false,
        name: yAxisCostName,
        title: flagLandscape ? AxisTitle(text: yAxisCostName) : null,
      ),
      axes: <ChartAxis>[
        NumericAxis(
          opposedPosition: true,
          name: yAxisVolumeName,
          title: flagLandscape ? AxisTitle(text: yAxisVolumeName) : null,
        )
      ],
      title: ChartTitle(
          text:
              '${stockDataSeries.stockSymbol} (${stockDataSeries.companyName})'),
      legend: Legend(isVisible: true),
      tooltipBehavior: TooltipBehavior(enable: true),
      series: <ChartSeries<StockDataSeries, String>>[
        LineSeries<StockDataSeries, String>(
          dataSource: stockDataSeries.valueDataStockSeries,
          xValueMapper: (StockDataSeries dataSeries, _) => dataSeries.date,
          yValueMapper: (StockDataSeries dataSeries, _) => dataSeries.value,
          yAxisName: yAxisCostName,
          dataLabelSettings: DataLabelSettings(isVisible: true),
          enableTooltip: true,
          legendItemText: yAxisCostTitleName,
          name: yAxisCostTitleName,
          markerSettings: MarkerSettings(
            isVisible: true,
            shape: DataMarkerType.rectangle,
          ),
        ),
        ColumnSeries(
          dataSource: stockDataSeries.valueDataStockSeries,
          xValueMapper: (StockDataSeries dataSeries, _) => dataSeries.date,
          yValueMapper: (StockDataSeries dataSeries, _) => dataSeries.volume,
          yAxisName: yAxisVolumeName,
          dataLabelSettings: DataLabelSettings(isVisible: true),
          enableTooltip: true,
          legendItemText: yAxisVolumeTitleName,
          name: yAxisVolumeTitleName,
          markerSettings: MarkerSettings(
            isVisible: true,
            shape: DataMarkerType.diamond,
          ),
        ),
      ],
    );
  }
}
