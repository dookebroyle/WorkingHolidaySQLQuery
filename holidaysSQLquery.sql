DECLARE @Year char(4) = 2021,
@FirstDayOfMonth int,
@FirstDateOfMonth date,
@Holiday date,
@WeekInMonth int = 1, 
@DayOfWeek int,
@DayOfWeekDiff int



-- New Years Day / January 1
SET @Holiday=CONVERT( date, CONVERT(varchar, YEAR( @Year ) )+'-01-01' ) 
IF DATENAME( dw, @Holiday ) = 'Saturday'
	SET @Holiday=DATEADD(day, -1,@Holiday)
ELSE IF DATENAME( dw, @Holiday ) = 'Sunday'
    SET @Holiday=DATEADD(day, 1, @Holiday)
SELECT @Holiday [New Years Day], DATENAME( dw, @Holiday ) [WeekDay]

-- Memorial Day/ Last Monday in May 
--get first date of month
SET @FirstDateOfMonth = CONVERT( date, CONVERT(varchar, YEAR( @Year ) )+'-05-01' ) 
--set nth week of month that holiday occurs in
SET @WeekInMonth = 5;
--set nth day of week that holiday occurs on yearly
SET @DayOfWeek = 2 -- MONDAY
-- update Holiday to the correct week. (multiply by 5 to get last week in May)
SET @Holiday = DATEADD(dd, (@WeekInMonth -1)*7, @FirstDateOfMonth)
--if the dayofweek of holiday matches correct day of week, work done
IF DATEPART(dw, @Holiday) = @DayOfWeek
BEGIN
	SELECT @Holiday [Memorial Day], DATENAME( dw, @Holiday ) [WeekDay]
END
ELSE 
--the day does not match, need to go forward or backward in week to get correct day
BEGIN
	--figure out distance between the two dates and find absolute value to add or subtract
	SET @DayOfWeekDiff = Abs(@DayOfWeek -DATEPART(dw, @Holiday))
	--if the day of the week comes after the holiday, move holiday forward
	IF @DayOfWeek > DATEPART(dw,@Holiday)
		SET @Holiday = DATEADD(day, @DayOfWeekDiff , @Holiday)
	--move holiday backward
	ELSE
		SET @Holiday = DATEADD(day, -@DayOfWeekDiff , @Holiday)
	SELECT @Holiday [Memorial Day], DATENAME( dw, @Holiday ) [WeekDay]
END

-- Independence Day /July 4 
SET @Holiday=CONVERT( date, CONVERT(varchar, YEAR( @Year ) )+'-07-04' ) 
IF DATENAME( dw, @Holiday ) = 'Saturday'
	SET @Holiday=DATEADD(day, -1,@Holiday)
ELSE IF DATENAME( dw, @Holiday ) = 'Sunday'
    SET @Holiday=DATEADD(day, 1,@Holiday)
SELECT @Holiday [Independence Day], DATENAME( dw, @Holiday ) [WeekDay]

-- Labor Day/ 1st Monday in September
--get first date of month
SET @FirstDateOfMonth = CONVERT( date, CONVERT(varchar, YEAR( @Year ) )+'-09-01' ) 
--set nth week of month that holiday occurs in
SET @WeekInMonth = 1;
--set nth day of week that holiday occurs on yearly
SET @DayOfWeek = 2 -- MONDAY
-- update Holiday to the correct week.
SET @Holiday = DATEADD(dd, (@WeekInMonth -1)*7 , @FirstDateOfMonth)
--if the @holiday var's is in week 1 and past monday - need to move into next week
IF DATEPART(dw, @Holiday) > @DayOfWeek --Monday
BEGIN
	SET @WeekInMonth = 2
	SET @Holiday = DATEADD(dd, (@WeekInMonth -1)*7, @FirstDateOfMonth)
END
--if the dayofweek of holiday matches correct day of week, work done
IF DATEPART(dw, @Holiday) = @DayOfWeek
	SELECT @Holiday [Labor Day], DATENAME( dw, @Holiday ) [WeekDay]
ELSE 
BEGIN
	--figure out distance between the two dates and find absolute value to add or subtract
	SET @DayOfWeekDiff = Abs(@DayOfWeek -DATEPART(dw, @Holiday)) 
	--if:  the @dayOfWeek of the actual holiday occurs on is after the temp holiday, go forward
	IF @DayOfWeek > DATEPART(dw,@Holiday)
	BEGIN
		SET @Holiday = DATEADD(day, @DayOfWeekDiff , @Holiday)
		SELECT @Holiday [Labor Day], DATENAME( dw, @Holiday ) [WeekDay]
	END
	-- else: @DayOfWeek of the actual holiday occurs on is before the temp holiday, go back
	ELSE
	BEGIN
		SET @Holiday = DATEADD(day, -@DayOfWeekDiff , @Holiday)
		SELECT @Holiday [Labor Day], DATENAME( dw, @Holiday ) [WeekDay]
	END
END
		


-- Veteran's Day / November 11 
SET @Holiday=CONVERT( date, CONVERT(varchar, YEAR( @Year ) )+'-11-11' ) 
IF DATENAME( dw, @Holiday ) = 'Saturday'
	SET @Holiday=DATEADD(day, -1,@Holiday)
ELSE IF DATENAME( dw, @Holiday ) = 'Sunday'
    SET @Holiday=DATEADD(day, 1,@Holiday)
SELECT @Holiday [Veteren's Day], DATENAME( dw, @Holiday ) [WeekDay]

-- Thanksgiving Day / 4th Thursday in November  
--get first date of month
SET @FirstDateOfMonth = CONVERT( date, CONVERT(varchar, YEAR( @Year ) )+'-11-01' ) 
--get day of week of first date of month
SET @FirstDayOfMonth = DATEPART(day, @FirstDateOfMonth)
--set nth week of month that holiday occurs in
SET @WeekInMonth = 4;
--set nth day of week that holiday occurs on yearly
SET @DayOfWeek = 5 -- THURSDAY
-- update Holiday to the correct week.
SET @Holiday = DATEADD(dd, (@WeekInMonth -1)*7, @FirstDateOfMonth) 
--if the dayofweek of holiday matches correct day of week, work done
IF DATEPART(dw, @Holiday) = @DayOfWeek
BEGIN
	SELECT @Holiday [Thanksgiving Day], DATENAME( dw, @Holiday ) [WeekDay]
END
ELSE 
BEGIN
	--figure out distance between the two dates and find absolute value to add or subtract
	SET @DayOfWeekDiff = Abs(@DayOfWeek -DATEPART(dw, @Holiday))
	--if real holiday comes after temp holiday, move forward
	IF @DayOfWeek > DATEPART(dw,@Holiday)
		SET @Holiday = DATEADD(day, @DayOfWeekDiff , @Holiday)
	--else move backward in week
	ELSE
		SET @Holiday = DATEADD(day, -@DayOfWeekDiff , @Holiday)
	SELECT @Holiday [Thanksgiving Day], DATENAME( dw, @Holiday ) [WeekDay]
END


-- Christmas Eve / December 24 
SET @Holiday=CONVERT( date, CONVERT(varchar, YEAR( @Year ) )+'-12-24' )
IF DATENAME( dw, @Holiday ) = 'Saturday'
	SET @Holiday=DATEADD(day, -1,@Holiday)
ELSE IF DATENAME( dw, @Holiday ) = 'Sunday'
    SET @Holiday=DATEADD(day, 1,@Holiday)
SELECT @Holiday [Christmas Eve], DATENAME( dw, @Holiday ) [WeekDay]


--Christmas Day / December 25 /
SET @Holiday=CONVERT( date, CONVERT(varchar, YEAR( @Year ) )+'-12-25' ) 
IF DATENAME( dw, @Holiday ) = 'Saturday'
	SET @Holiday=DATEADD(day, -1,@Holiday)
ELSE IF DATENAME( dw, @Holiday ) = 'Sunday'
    SET @Holiday=DATEADD(day, 1,@Holiday)
SELECT @Holiday [Christmas Day], DATENAME( dw, @Holiday ) [WeekDay]