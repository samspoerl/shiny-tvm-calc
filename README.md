# Shiny TVM Calculator
Time Value of Money calculator using R Shiny.

## Getting Started

You will need R, RStudio, and the libraries below. To run the application locally, click "Run App" in the upper-right corner of the scripting quadrant.

## Usage

The purpose of this application is calculate the future value of an investment. This requires four inputs:

**Inputs**
1. Present Value - the amount invested at the beginning of the time period
2. Payment - the amount continually invested at the end of each period
3. Interest Rate - the rate of return earned on the investment
4. Number of Periods - the number of periods interest is compounding and payments are being added

The text at the top of the main panel shows the value of the investment at the end of the final period (i.e., if the Number of Periods slider is set to 20, it shows the value of the investment after 20 periods). Period is not necessarily years. For example, to compound by month: multiply Number of Periods by 12, divide Payment by 12, and divide Interest Rate by 12.

The plot in the main panel shows the value of the investment for each period for however many periods are selected in Number of Periods.

## Libraries

* shiny
* FinCal

## Scripts

1. app.R - Main application script
2. utils.R - Helper script to return future value schedule as a dataframe
