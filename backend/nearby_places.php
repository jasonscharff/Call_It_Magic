<?php
	
	require('OAuth.php');
	
	$CONSUMER_KEY = "OEzP0fTralgEqmfTat9iGA";
	$CONSUMER_SECRET = "gzOs6j4RWzmsqxY6RywG9VzmLhI";
	$TOKEN = "Vsr5fARgehoMVAzL1jZsvhEYpLbjHlVK";
	$TOKEN_SECRET = "bhRGh4XhDNbz-RUOCxbL_Nd8J7U";
	
	$API_HOST = 'api.yelp.com';
	$DEFAULT_TERM = 'dinner';
	$DEFAULT_LOCATION = 'San Francisco, CA';
	$SEARCH_LIMIT = 3;
	$SEARCH_PATH = '/v2/search/';
	$BUSINESS_PATH = '/v2/business/';
	
	ini_set('max_execution_time', 0);
	$places['places'] = array();

	
		
	$results = json_decode(pmRequest('https://ipa.postmates.com/v1/places?lat=39.90105447115481&lng=-75.17112091135539'), TRUE);
	foreach ($results['places'] as $result) {
		
		$place_name = $result['name'];
		$lat = $result['lat'];
		$lng = $result['lng'];
		
		$yelp_response = request($GLOBALS['API_HOST'], "/v2/search/?term=$place_name&location=Philadelphia, PN&cll=$lat,$lng");
		
		$yelp_response = json_decode($yelp_response, TRUE);
		$yelp_data = '';
		$yelp_data = array('rating' => $yelp_response['businesses'][0]['rating'], 'url'=> $yelp_response['businesses'][0]['mobile_url'], 'ratingimg' => $yelp_response['businesses'][0]['rating_img_url_large'], 'id' => $yelp_response['businesses'][0]['id']);

		$uuid = $result['uuid'];
		
		$single = json_decode(pmRequest("https://ipa.postmates.com/v1/places/$uuid"), TRUE);
		
		foreach ($single['catalog']['categories'] as $category) {
			$category_uuid = $category['uuid'];
			$items = json_decode(pmRequest("https://ipa.postmates.com/v1/categories/$category_uuid/products?limit=40&offset=0"), TRUE);
			foreach ($items['products'] as $item) {
				
				$place = array();
				if ($result['name'] == 'Postmates General Store') {
					$place['place_name'] = "RiteAid";
				}else {
					$place['place_name'] = $result['name'];
				}
				$place['_geoloc'] = array('lat' => $result['lat'], 'lng' => $result['lng']);
				$place['place_uuid'] = $result['uuid'];
				$place['category_uuid'] = $category_uuid;
				$place['item_uuid'] = $item['uuid'];
				$place['item_name'] = $item['name'];
				$place['type'] = $category['name'];
				$place['item_price'] = $item['base_price'];
				$place['yelp'] = $yelp_data;
				array_push($places['places'], $place);
			}
		}
	
	}
	
	echo json_encode($places);

	
	function pmRequest($url) {
		
		$ch = curl_init();
		curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
		curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
		curl_setopt($ch, CURLOPT_USERAGENT, 'Get It Now 2.8 rv:383 (device_model:iPhone; system_os:iPhone OS; system_version:9.0; en_US)');
		curl_setopt($ch, CURLOPT_URL, $url);
		$result = curl_exec($ch);
		curl_close($ch);
		
		return $result;
		
	}
	
	function request($host, $path) {
	    $unsigned_url = "http://" . $host . $path;
	    // Token object built using the OAuth library
	    $token = new OAuthToken($GLOBALS['TOKEN'], $GLOBALS['TOKEN_SECRET']);
	    // Consumer object built using the OAuth library
	    $consumer = new OAuthConsumer($GLOBALS['CONSUMER_KEY'], $GLOBALS['CONSUMER_SECRET']);
	    // Yelp uses HMAC SHA1 encoding
	    $signature_method = new OAuthSignatureMethod_HMAC_SHA1();
	    $oauthrequest = OAuthRequest::from_consumer_and_token(
	        $consumer, 
	        $token, 
	        'GET', 
	        $unsigned_url
	    );
	    
	    // Sign the request
	    $oauthrequest->sign_request($signature_method, $consumer, $token);
	    
	    // Get the signed URL
	    $signed_url = $oauthrequest->to_url();
	    
	    // Send Yelp API Call
	    $ch = curl_init($signed_url);
	    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
	    curl_setopt($ch, CURLOPT_HEADER, 0);
	    $data = curl_exec($ch);
	    curl_close($ch);
	    
	    return $data;
	}

