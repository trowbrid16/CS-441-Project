#add extra column that includes if it's a green lane.
# SW Broadway 2009
# SW Moody 2011
# NE Cully Blvd. 2011
# NE Multnoma St. 2012

# Get text from json file
$jsonFilePath = "C:\Users\Casey Sigelmann\Desktop\Software Egr"
$jsonFile = $jsonFilePath + "\portland_accidents.json"
$jsonText = Get-Content $jsonFile

# Loop through the lines
foreach($line in $jsonText)
{
    
}
