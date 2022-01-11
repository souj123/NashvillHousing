--CLEANING DATA IN SQL QUERIES

select * 
from projectPortfolio..NashvillHousing

--STANDARDIZE DATE FORMAT

select Salesdatecnvrtd, convert(Date,SaleDate)
from projectPortfolio..NashvillHousing

update NashvillHousing
set SaleDate=convert(Date,SaleDate)

alter table NashvillHousing
add Salesdatecnvrtd Date;

update NashvillHousing
set Salesdatecnvrtd = convert(Date,SaleDate)

--POPULATE PROPERTY ADDRESS DATA

select *
from projectPortfolio..NashvillHousing
where PropertyAddress is null
--order by ParcelID

--DOING SELF JOIN (because in some places property address is null and property adddres  can not be null coz house cannot change ots position. whereas owner can change theor address.so where ever
--parcelid is same in 2 rows then its  property address is also same. 

select a.ParcelID,a.PropertyAddress,b.ParcelID,b.PropertyAddress, isnull(a.PropertyAddress,b.PropertyAddress)
from projectPortfolio..NashvillHousing a
join projectPortfolio..NashvillHousing b
on a.ParcelID=b.ParcelID
and a.[UniqueID ]<>b.[UniqueID ]
where a.PropertyAddress is null

update a
set PropertyAddress=isnull(a.PropertyAddress,b.PropertyAddress)
from projectPortfolio..NashvillHousing a
join projectPortfolio..NashvillHousing b
on a.ParcelID=b.ParcelID
and a.[UniqueID ]<>b.[UniqueID ]
where a.PropertyAddress is null

--BREAKING OT ADDRESS INTO INDIVIDUAL COLUMNS (address,city,states)

select PropertyAddress
from projectPortfolio..NashvillHousing
--where PropertyAddress is null
--order by ParcelID

select 
SUBSTRING(propertyaddress, 1,CHARINDEX(',',PropertyAddress) -1) as address
,SUBSTRING(propertyaddress,CHARINDEX(',',PropertyAddress) +1,len(PropertyAddress)) as address
from projectPortfolio..NashvillHousing

alter table NashvillHousing
add propertysplitaddress nvarchar(255);

update NashvillHousing
set propertysplitaddress = SUBSTRING(propertyaddress, 1,CHARINDEX(',',PropertyAddress) -1)

alter table NashvillHousing
add propertysplitcity nvarchar(255);

update NashvillHousing
set propertysplitcity = SUBSTRING(propertyaddress,CHARINDEX(',',PropertyAddress) +1,len(PropertyAddress))

select *
from projectPortfolio..NashvillHousing

alter table NashvillHousing
drop column Salesdateconvert
alter table NashvillHousing
drop column Salesdateconvertedd
alter table NashvillHousing
drop column Salesdatecnvrtd


select owneraddress
from NashvillHousing 


select 
PARSENAME(replace(owneraddress,',',','),3),
PARSENAME(replace(owneraddress,',',','),2),
PARSENAME(replace(owneraddress,',',','),1)
from projectPortfolio..NashvillHousing


ALTER TABLE NashvillHousing
Add OwnerSplitAddress Nvarchar(255);

Update NashvillHousing
SET OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 3)


ALTER TABLE NashvillHousing
Add OwnerSplitCity Nvarchar(255);

Update NashvillHousing
SET OwnerSplitCity = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 2)



ALTER TABLE NashvillHousing
Add OwnerSplitState Nvarchar(255);

Update NashvillHousing
SET OwnerSplitState = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 1)



Select *
From NashvillHousing




--------------------------------------------------------------------------------------------------------------------------


-- Change Y and N to Yes and No in "Sold as Vacant" field


Select Distinct(SoldAsVacant), Count(SoldAsVacant) 
From NashvillHousing
Group by SoldAsVacant
order by 2




Select SoldAsVacant
, CASE When SoldAsVacant = 'Y' THEN 'Yes'
	   When SoldAsVacant = 'N' THEN 'No'
	   ELSE SoldAsVacant
	   END
From NashvillHousing


Update NashvillHousing
SET SoldAsVacant = CASE When SoldAsVacant = 'Y' THEN 'Yes'
	   When SoldAsVacant = 'N' THEN 'No'
	   ELSE SoldAsVacant
	   END






-----------------------------------------------------------------------------------------------------------------------------------------------------------

-- Remove Duplicates

WITH RowNumCTE AS(
Select *,
	ROW_NUMBER() OVER (
	PARTITION BY ParcelID,
				 PropertyAddress,
				 SalePrice,
				 SaleDate,
				 LegalReference
				 ORDER BY
					UniqueID
					) row_num

From NashvillHousing
--order by ParcelID
)
select *
From RowNumCTE
Where row_num > 1
--Order by PropertyAddress



Select *
From NashvillHousing




---------------------------------------------------------------------------------------------------------

-- Delete Unused Columns



Select *
From NashvillHousing


ALTER TABLE NashvillHousing
DROP COLUMN OwnerAddress, TaxDistrict, PropertyAddress, SaleDate
