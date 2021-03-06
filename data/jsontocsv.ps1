#add extra column that includes if it's a green lane.
# SW Broadway 2009
# SW Moody 2011
# NE Cully Blvd. 2011
# NE Multnoma St. 2012


# This function trims a line of everything except the value
function TrimLine($trimLine)
{
    #remove junk of the front of the string
    $trimLine = $line -replace ".*:", ""
        
    #remove junk off the end of the string
    $trimLine = $trimLine -replace ",.*", ""

    return $trimLine
}



# Get text from json file
$jsonFilePath = $PSScriptRoot
$jsonFile = $jsonFilePath + "\portland_accidents.json"
$jsonText = Get-Content $jsonFile

# csv file
$csvFile = $jsonFilePath + "\portland_accidents.csv"

# create the beginning of the csv
"sep=," > $csvFile
"Street1,Street2,ImageID,NumAccidents,Year,Latitude,Longitude,CrashID" >> $csvFile

# things we want to find
$street1 = ""
$street2 = ""
$imageId = ""
$noAccidents = ""
$year = ""
$lat = ""
$lng = ""
$crashId = ""

# Loop through the lines
$count = 0
$isContents = $false
foreach($line in $jsonText)
{
    $count2 = $count2 + 1
    if($line -match "\{") # New object, make sure variables are reset
    {
        $street1 = ""
        $street2 = ""
        $imageId = ""
        $noAccidents = ""
        $year = ""
        $lat = ""
        $lng = ""
        $crashId = ""
    }
    elseif($line -match ".*street1.*")
    {
        $street1 = TrimLine($line)

        #remove quotes
        $street1 = $street1 -replace "`"", ""
    }
    elseif($line -match ".*street2.*")
    {
        $street2 = TrimLine($line)

        #remove quotes
        $street2 = $street2 -replace "`"", ""
    }
    elseif($line -match ".*image_id.*")
    {
        $imageId = TrimLine($line)
    }
    elseif($line -match ".*noAccidents.*")
    {
        $noAccidents = TrimLine($line)
    }
    elseif($line -match ".*year.*")
    {
        $year = TrimLine($line)

        #remove quotes
        $year = $year -replace "`"", ""
    }
    elseif($line -match ".*lat.*")
    {
        $lat = TrimLine($line)
    }
    elseif($line -match ".*lng.*")
    {
        $lng = TrimLine($line)
    }
    elseif($line -match ".*crashID.*")
    {
        $crashId = TrimLine($line)

        #remove quotes and spaces
        $crashId = $crashId -replace " *`"", ""
    }
    elseif($line -match "\}") #end of object, need to write
    {
        $lineToWrite = "$street1,$street2,$imageId,$noAccidents,$year,$lat,$lng,$crashId"
        
        $lineToWrite >> $csvFile
    }
}
