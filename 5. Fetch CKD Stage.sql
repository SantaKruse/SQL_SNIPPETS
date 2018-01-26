CREATE	FUNCTIOn UFF_CKD_STAGE 
(
			@IN	AS	FLOAT

)
RETURNS		VARCHAR(2)
AS
BEGIN
			DECLARE		@OUT	AS	VARCHAR(2)
			
			SET @OUT = (CASE 
						WHEN @IN IS NULL THEN NULL
						WHEN @IN >= 200 THEN 'OR'
						WHEN @IN >= 90 THEN '1'
						WHEN @IN >= 60 THEN '2'
						WHEN @IN >= 45 THEN '3a'
						WHEN @IN >= 30 THEN '3b'
						WHEN @IN >= 15 THEN '4'
						WHEN @IN >= 0.01 THEN '5'
						WHEN @IN < 0.01 THEN 'OR'
						END)
											
			RETURN	@OUT

END


GO
