#Occupancy Rate by Hotel and Month
SELECT
    property_name,
    month_year,
    COUNT(*) AS total_bookings,
    SUM(no_guests) AS total_guests
FROM sys.fact_bookings_cleaned
WHERE booking_status = 'Checked Out'
GROUP BY property_name, month_year
ORDER BY total_bookings DESC;

#Cancellation Rate by Platform
SELECT
    booking_platform,
    COUNT(*) AS total_bookings,
    SUM(is_cancelled) AS cancelled,
    ROUND(SUM(is_cancelled) / COUNT(*) * 100, 2) AS cancellation_rate
FROM sys.fact_bookings_cleaned
GROUP BY booking_platform
ORDER BY cancellation_rate DESC;

#Average Revenue per Stay (RevPAR) by Room Type
SELECT
    room_type,
    ROUND(AVG(revenue_realized), 2) AS avg_revenue,
    ROUND(AVG(stay_duration), 2) AS avg_stay,
    ROUND(AVG(revenue_realized) / AVG(stay_duration), 2) AS RevPAR
FROM sys.fact_bookings_cleaned
WHERE booking_status = 'Checked Out'
GROUP BY room_type;

#Top Performing Cities by Revenue
SELECT
    city,
    SUM(revenue_realized) AS total_revenue
FROM sys.fact_bookings_cleaned
WHERE booking_status = 'Checked Out'
GROUP BY city

ORDER BY total_revenue DESC;

#Ratings vs Cancellation Behavior
SELECT
    is_cancelled,
    AVG(ratings_given) AS avg_rating
FROM sys.fact_bookings_cleaned
GROUP BY is_cancelled;

#Revenue Lost Due to Cancellations
SELECT
    month_year,
    SUM(revenue_generated - revenue_realized) AS revenue_loss
FROM sys.fact_bookings_cleaned
WHERE booking_status = 'Cancelled'
GROUP BY month_year
ORDER BY month_year;

#RevPAR (Revenue per Available Room)
SELECT
    room_type,
    ROUND(SUM(revenue_realized) / COUNT(DISTINCT check_in_date), 2) AS revpar
FROM sys.fact_bookings_cleaned
WHERE booking_status = 'Checked Out'
GROUP BY room_type
ORDER BY revpar DESC;

#Room Type Performance Summary
SELECT
    room_type,
    COUNT(*) AS total_bookings,
    SUM(revenue_realized) AS total_revenue,
    ROUND(AVG(ratings_given), 2) AS avg_rating,
    ROUND(SUM(is_cancelled) / COUNT(*) * 100, 2) AS cancellation_rate
FROM sys.fact_bookings_cleaned
GROUP BY room_type
ORDER BY total_revenue DESC;

#Average Stay Duration by Property
SELECT
    property_name,
    ROUND(AVG(stay_duration), 2) AS avg_stay
FROM sys.fact_bookings_cleaned
WHERE booking_status = 'Checked Out'
GROUP BY property_name
ORDER BY avg_stay DESC;

#Daily Booking Trend
SELECT
    check_in_date,
    COUNT(*) AS bookings
FROM sys.fact_bookings_cleaned
GROUP BY check_in_date
ORDER BY check_in_date;

#Most Canceled Room Categories
SELECT
    room_type,
    COUNT(*) AS total_bookings,
    SUM(is_cancelled) AS total_cancelled,
    ROUND(SUM(is_cancelled) / COUNT(*) * 100, 2) AS cancellation_rate
FROM sys.fact_bookings_cleaned
GROUP BY room_type
ORDER BY cancellation_rate DESC;

# Revenue Breakdown by Day Type 
SELECT
    day_type,
    SUM(revenue_realized) AS total_revenue,
    COUNT(*) AS total_bookings,
    ROUND(SUM(revenue_realized) / COUNT(*), 2) AS avg_revenue_per_booking
FROM sys.fact_bookings_cleaned
WHERE booking_status = 'Checked Out'
GROUP BY day_type;

