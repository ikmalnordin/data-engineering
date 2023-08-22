BASEURL=

#e.g."https://newss.statistics.gov.my/newss-portalx/ep/epFreeDownloadContentSearch.seam?contentId=182738&amp;actionMethod=ep%2FepFreeDownloadContentSearch.xhtml%3AcontentAction.doDisplayContent&amp;cid=8564"

BASEURL=$(echo "$BASEURL" | sed 's/&amp;/\&/g; s/%3A/:/g')

#YEAR=2022
#QUARTER=2

USERNAME=
PASSWORD=

#if curl does not work, can switch to wget
curl -o bop_${QUARTER}_${YEAR}.xlsx --user $USERNAME:$PASSWORD $BASEURL
#wget -O bop_${QUARTER}_${YEAR}.xlsx --user $USERNAME:$PASSWORD $BASEURL

BUCKET=
e.g. gs://website-download-test-dosm

#export to GCS bucket
gsutil -m cp bop_2_2022.xlsx $BUCKET



