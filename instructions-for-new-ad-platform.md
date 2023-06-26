# Adding Data from New Ad Platform to MCDM

## Overview
This guide outlines the steps to add data from a new ad platform to the MCDM (Multi-Criteria Decision Making) structure. By following these instructions, you can expand the analysis to include insights from additional channels.

## Prerequisites
- Access to the data source of the new ad platform.
- Understanding of the existing MCDM structure and data retrieval process.

## Steps

1. Identify the New Ad Platform
   - Determine the ad platform from which you want to include data in the MCDM structure.

2. Modify the SQL Query: mcdm_structure_all.sql
   - Open the SQL query file that defines the MCDM structure.
   - Locate the section where data is retrieved for other ad platforms.
   - Create a new Common Table Expression (CTE) to calculate metrics for the new ad platform.
   - Include the necessary columns and calculations based on the available data from the new platform.
   - Ensure that the column names align with the existing structure.

3. Calculate Additional Metrics
   - After creating the CTE for the new ad platform, calculate additional metrics specific to that platform.
   - Consider metrics such as Cost per Click (CPC), Cost per Engagement, Conversion cost and total impressions
   - Adjust the calculations based on the available data and business requirements.

4. Update the Final SELECT Statement
   - Modify the final SELECT statement to include the metrics from the new ad platform.
   - Ensure that the column names align with the existing columns in the structure.
   - Include the new platform's metrics in the UNION ALL section, combining them with the metrics from other platforms.

5. Test and Validate
   - Run the modified SQL query to verify that it retrieves data from the new ad platform correctly.
   - Check for any errors or inconsistencies.
   - Validate that the calculated metrics align with your expectations.

## Conclusion
By following these steps, you can successfully add data from a new ad platform to the MCDM structure. Remember to document the modifications made in the SQL query and keep the MCDM documentation up to date.

