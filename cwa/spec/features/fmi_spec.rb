require 'rails_helper'

#require 'webmock/rspec'

describe 'FmiAPi' do

  before :all do
    self.use_transactional_fixtures = false
    WebMock.disable_net_connect!(allow_localhost:true,)
  end

  it 'Should show temperature of kumpula', js:true do

    canned_answ = <<eos
    <?xml version='1.0' encoding='UTF-8'?>
        <wfs:FeatureCollection
    timeStamp='2015-05-19T09:41:58Z'
    numberMatched='1'
    numberReturned='1'
    xmlns:wfs='http://www.opengis.net/wfs/2.0'
    xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance'

    xmlns:xlink='http://www.w3.org/1999/xlink'
    xmlns:om='http://www.opengis.net/om/2.0'
    xmlns:ompr='http://inspire.ec.europa.eu/schemas/ompr/2.0'
    xmlns:omso='http://inspire.ec.europa.eu/schemas/omso/2.0'
    xmlns:gml='http://www.opengis.net/gml/3.2'
    xmlns:gmd='http://www.isotc211.org/2005/gmd'
    xmlns:gco='http://www.isotc211.org/2005/gco'
    xmlns:swe='http://www.opengis.net/swe/2.0'
    xmlns:gmlcov='http://www.opengis.net/gmlcov/1.0'
    xmlns:sam='http://www.opengis.net/sampling/2.0'
    xmlns:sams='http://www.opengis.net/samplingSpatial/2.0'
    xmlns:target='http://xml.fmi.fi/namespace/om/atmosphericfeatures/1.0'
    xsi:schemaLocation='http://www.opengis.net/wfs/2.0 http://schemas.opengis.net/wfs/2.0/wfs.xsd
  http://www.opengis.net/gmlcov/1.0 http://schemas.opengis.net/gmlcov/1.0/gmlcovAll.xsd
  http://www.opengis.net/sampling/2.0 http://schemas.opengis.net/sampling/2.0/samplingFeature.xsd
  http://www.opengis.net/samplingSpatial/2.0 http://schemas.opengis.net/samplingSpatial/2.0/spatialSamplingFeature.xsd
  http://www.opengis.net/swe/2.0 http://schemas.opengis.net/sweCommon/2.0/swe.xsd
  http://inspire.ec.europa.eu/schemas/ompr/2.0 http://inspire.ec.europa.eu/schemas/ompr/2.0/Processes.xsd
  http://inspire.ec.europa.eu/schemas/omso/2.0 http://inspire.ec.europa.eu/schemas/omso/2.0/SpecialisedObservations.xsd
  http://xml.fmi.fi/namespace/om/atmosphericfeatures/1.0 http://xml.fmi.fi/schema/om/atmosphericfeatures/1.0/atmosphericfeatures.xsd'>

    <wfs:member>
    <omso:GridSeriesObservation gml:id='WFS-p8RdI3ig00k4bfRgi308DDo9f_qJTowroWbbpdOt.Lnl5dsPTTv3c3Trvlw9NGXk6dbeuzpp4b9O7pj39svLDnywtLFlz6d1TTty2v_oUrNgk8MbHy51qRaFOO6dNGTVwzsu7JU07ctr_6FKzYJqoTO15fPffyyVMzZvx4dmWtTNpvxpK7r0zOGttw.Imnn0w7seWlauhAaW3D4i8N.PRznBjmb23L0y76GHlh25emXlzrW6ZdvDLyw9OvLK1tunnz07s9TL46VjTsM5tbuu2fmp9MPTTv3c5wmZw2YceXnXBr67eHXZhWSMuznp3a9LW49cOzT08yd2bfWNvzZmtz6YemnfuqeeGWtDfwy7smHphbnPpv5ZcnHrl5eb.nJW6Fm26XTrfi55eXbD00793N0675cPTRl5OnW3rs6aeG_Tu6Y9_bLyw58rQ6aduWn0y8J.Qmh007ctrfuy1jVakMA-'>

                                <om:phenomenonTime>
    <gml:TimePeriod gml:id='time1-1-1'>
                    <gml:beginPosition>2015-05-19T08:00:00Z</gml:beginPosition>
          <gml:endPosition>2015-05-19T12:00:00Z</gml:endPosition>
    </gml:TimePeriod>
      </om:phenomenonTime>
    <om:resultTime>
    <gml:TimeInstant gml:id='time2-1-1'>
                     <gml:timePosition>2015-05-19T12:00:00Z</gml:timePosition>
        </gml:TimeInstant>
    </om:resultTime>

     <om:procedure xlink:href='http://xml.fmi.fi/inspire/process/opendata'/>
                 <om:parameter>
                <om:NamedValue>
                    <om:name xlink:href='http://inspire.ec.europa.eu/codeList/ProcessParameterValue/value/groundObservation/observationIntent'/>
                    <om:value>
			atmosphere
                    </om:value>
                </om:NamedValue>
            </om:parameter>

     <om:observedProperty  xlink:href='http://data.fmi.fi/fmi-apikey/076c2196-7be3-49ed-8be2-5ed9f51a4883/meta?observableProperty=observation&amp;param=temperature&amp;language=eng'/>
     	<om:featureOfInterest>
        <sams:SF_SpatialSamplingFeature gml:id='sampling-feature-1-1-fmisid'>

          <sam:sampledFeature>
		<target:LocationCollection gml:id='sampled-target-1-1'>
		    <target:member>
		    <target:Location gml:id='obsloc-fmisid-101004-pos'>
		        <gml:identifier codeSpace='http://xml.fmi.fi/namespace/stationcode/fmisid'>101004</gml:identifier>
			<gml:name codeSpace='http://xml.fmi.fi/namespace/locationcode/name'>Helsinki Kumpula</gml:name>
			<gml:name codeSpace='http://xml.fmi.fi/namespace/locationcode/geoid'>-16000138</gml:name>
			<gml:name codeSpace='http://xml.fmi.fi/namespace/locationcode/wmo'>2998</gml:name>
			<target:representativePoint xlink:href='#point-101004'/>


    <target:region codeSpace='http://xml.fmi.fi/namespace/location/region'>Helsinki</target:region>

		    </target:Location></target:member>
		</target:LocationCollection>
    </sam:sampledFeature>
          <sams:shape>
            <gml:MultiPoint gml:id='mp-1-1-fmisid'>
              <gml:pointMember>
              <gml:Point gml:id='point-101004' srsName='http://www.opengis.net/def/crs/EPSG/0/4258' srsDimension='2'>
                <gml:name>Helsinki Kumpula</gml:name>
                <gml:pos>60.20307 24.96130 </gml:pos>
            </gml:Point>
	    </gml:pointMember>
	    </gml:MultiPoint>
          </sams:shape>
        </sams:SF_SpatialSamplingFeature>
      </om:featureOfInterest>

           <om:result>
        <gmlcov:MultiPointCoverage gml:id='mpcv1-1-1'>
          <gml:domainSet>
            <gmlcov:SimpleMultiPoint gml:id='mp1-1-1' srsName='http://xml.fmi.fi/gml/crs/compoundCRS.php?crs=4258&amp;time=unixtime' srsDimension='3'>
              <gmlcov:positions>
                60.20307 24.96130  1432022400
                60.20307 24.96130  1432026000
                60.20307 24.96130  1432029600
                60.20307 24.96130  1432033200
                60.20307 24.96130  1432036800
                </gmlcov:positions>
            </gmlcov:SimpleMultiPoint>
          </gml:domainSet>
          <gml:rangeSet>
            <gml:DataBlock>
              <gml:rangeParameters/>
              <gml:doubleOrNilReasonTupleList>
                13.5
                12.0
                NaN
                NaN
                NaN
                </gml:doubleOrNilReasonTupleList>
            </gml:DataBlock>
          </gml:rangeSet>
          <gml:coverageFunction>
            <gml:CoverageMappingRule>
              <gml:ruleDefinition>Linear</gml:ruleDefinition>
            </gml:CoverageMappingRule>
          </gml:coverageFunction>
          <gmlcov:rangeType>
            <swe:DataRecord>
              <swe:field name='temperature'  xlink:href='http://data.fmi.fi/fmi-apikey/076c2196-7be3-49ed-8be2-5ed9f51a4883/meta?observableProperty=observation&amp;param=temperature&amp;language=eng'/>
              </swe:DataRecord>
          </gmlcov:rangeType>
        </gmlcov:MultiPointCoverage>
      </om:result>

    </omso:GridSeriesObservation>
  </wfs:member>
</wfs:FeatureCollection>

eos

    stub_request(:get, /.*kumpula/).to_return(body: canned_answ, headers: { 'Content-Type' => "text/xml" })
    visit root_path
   # save_and_open_page
    #find(:css, "#cityID[value='temperature']").set(true)
    click_button('temperature')
    expect(page).to have_content 'kumpula, Helsinki'

    end
end
