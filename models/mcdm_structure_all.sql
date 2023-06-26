-- Create a CTE for each channel to calculate metrics
With bing_metrics AS (
    SELECT
        'Bing' AS channel,
        SUM(clicks) AS clicks,
        SUM(imps) AS impression,
        SUM(spend) AS cost,
        SUM(conv) AS conversions
    FROM
        {{ ref('src_ads_bing_all_data') }}
),
-- Calculate additional metrics for Bing
bing_additional_metrics AS (
    SELECT
        channel,
        SUM(cost) AS total_cost,
        SUM(clicks) AS total_clicks,
        SUM(conversions) AS total_conversions,
        0 AS impressions, -- There is no column of impressions
        SUM(cost) / SUM(clicks) AS CPC,
        SUM(cost) / SUM(conversions) AS conversion_cost,
        0 AS cost_per_engagement -- There is no column of engagement
    FROM
        bing_metrics
    Group by
        channel
),
-- Facebook Metrics
facebook_metrics AS (
    SELECT
        'Facebook' AS channel,
        SUM(clicks) AS clicks,
        SUM(impressions) AS impression,
        SUM(spend) AS cost,
        SUM(purchase) AS conversions,
        SUM(views) AS engagements
    FROM
        {{ ref('src_ads_creative_facebook_all_data') }}
),
-- Calculate additional metrics for Facebook
facebook_additional_metrics AS (
    SELECT
        channel,
        SUM(cost) AS total_cost,
        SUM(clicks) AS total_clicks,
        SUM(conversions) AS total_conversions,
        SUM(impression) AS impressions,
        SUM(cost) / SUM(clicks) AS CPC,
        SUM(cost) / SUM(conversions) AS conversion_cost,
        SUM(cost) / (SUM(engagements) + SUM(clicks)) AS cost_per_engagement
    FROM
        facebook_metrics
    Group by
        channel   
),
-- TikTok Metrics
tiktok_metrics AS (
    SELECT
        'TikTok' AS channel,
        SUM(spend) AS cost,
        SUM(purchase) AS total_conversions,
        SUM(impressions) AS impression,
        SUM(conversions) AS conversions,
        SUM(clicks) AS clicks
    FROM
        {{ ref('src_ads_tiktok_ads_all_data') }}
),
-- Calculate additional metrics for TikTok
tiktok_additional_metrics AS (
    SELECT
        channel,
        SUM(cost) AS total_cost,
        SUM(clicks) AS total_clicks,
        SUM(conversions) AS total_conversions,
        SUM(impression) AS impressions,
        SUM(cost) / SUM(clicks) AS CPC,
        SUM(cost) / SUM(conversions) AS conversion_cost,
        0 AS cost_per_engagement --There is no column of engagement
    FROM
        tiktok_metrics
    Group by
        channel
),
-- Twitter Metrics
twitter_metrics AS (
    SELECT
        'Twitter' AS channel,
        SUM(spend) AS cost,
        SUM(engagements) AS engagements,
        SUM(impressions) AS impression,
        SUM(clicks) AS clicks
    FROM
        {{ ref('src_promoted_tweets_twitter_all_data') }}
),
-- Calculate additional metrics for Twitter
twitter_additional_metrics AS (
    SELECT
        channel,
        SUM(cost) AS total_cost,
        SUM(clicks) AS total_clicks,
        SUM(impression) AS impressions,
        SUM(cost) / SUM(clicks) AS CPC,
        0 AS conversion_cost,
        SUM(cost) / SUM(engagements) AS cost_per_engagement
    FROM
        twitter_metrics
    Group by
        channel 
)
SELECT
    channel,
    cost_per_engagement,
    conversion_cost,
    impressions,
    cpc
FROM
    bing_additional_metrics
UNION ALL
SELECT
    channel,
    cost_per_engagement,
    conversion_cost,
    impressions,
    cpc
FROM
    facebook_additional_metrics
UNION ALL
SELECT
    channel,
    cost_per_engagement,
    conversion_cost,
    impressions,
    cpc
FROM
    tiktok_additional_metrics
UNION ALL
SELECT
    channel,
    cost_per_engagement,
    conversion_cost,
    impressions,
    cpc
FROM
    twitter_additional_metrics