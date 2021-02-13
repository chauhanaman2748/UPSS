import 'package:flutter/material.dart';
import 'package:urbanparivarsevasamiti/models/channel_model.dart';
import 'package:urbanparivarsevasamiti/models/video_model.dart';
import 'package:urbanparivarsevasamiti/screens/send_mail.dart';
import 'package:urbanparivarsevasamiti/screens/video_screen.dart';
import 'package:urbanparivarsevasamiti/services/api_service.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Channel _channel;
  bool _isLoading = false;
  int _currentIndex = 2;
  CarouselSlider carouselSlider;
  int _current = 0;


  List imgList = [
    'assets/images/c1.jpg',
    'assets/images/c2.jpg',
    'assets/images/c3.jpg',
    'assets/images/c4.jpg',
    'assets/images/c5.jpg',
    'assets/images/c6.jpg',
    'assets/images/c7.jpg',
    'assets/images/c8.jpg',
    'assets/images/c9.jpg',
    ];

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  @override
  void initState() {
    super.initState();
    _initChannel();
  }


  _initChannel() async {
    Channel channel = await APIService.instance
        .fetchChannel(channelId: 'UCxORqwzk2JHKfsRUDHjX_tw');
    setState(() {
      _channel = channel;
    });
  }

  _buildProfileInfo() {
    return Container(
      margin: EdgeInsets.all(20.0),
      padding: EdgeInsets.all(20.0),
      height: 100.0,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0, 1),
            blurRadius: 6.0,
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          CircleAvatar(
            backgroundColor: Colors.white,
            radius: 35.0,
            backgroundImage: NetworkImage(_channel.profilePictureUrl),
          ),
          SizedBox(width: 12.0),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  _channel.title,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),/*
                Text(
                  '${_channel.subscriberCount} subscribers',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),*/
              ],
            ),
          )
        ],
      ),
    );
  }

  _buildVideo(Video video) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => VideoScreen(id: video.id),
        ),
      ),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
        padding: EdgeInsets.all(10.0),
        height: 140.0,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(0, 1),
              blurRadius: 6.0,
            ),
          ],
        ),
        child: Row(
          children: <Widget>[
            Image(
              width: 150.0,
              image: NetworkImage(video.thumbnailUrl),
            ),
            SizedBox(width: 10.0),
            Expanded(
              child: Text(
                video.title,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _loadMoreVideos() async {
    _isLoading = true;
    List<Video> moreVideos = await APIService.instance
        .fetchVideosFromPlaylist(playlistId: _channel.uploadPlaylistId);
    List<Video> allVideos = _channel.videos..addAll(moreVideos);
    setState(() {
      _channel.videos = allVideos;
    });
    _isLoading = false;
  }

  final tabs = [
    Container(
      alignment: Alignment.center,
      color: Colors.black,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Loading Images',
            style: TextStyle(
                fontSize: 50,
                color: Colors.white
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.lightBlue),)
        ],
      ),
    ),
    Container(
      color: Colors.black,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Loading Video',
            style: TextStyle(
                fontSize: 50,
                color: Colors.white
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.lightBlue),)
        ],
      ),
    ),
    Container(
      color: Colors.black,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Loading Profile',
            style: TextStyle(
                fontSize: 50,
                color: Colors.white
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.lightBlue),)
        ],
      ),
    ),
    SingleChildScrollView(
      child: Container(
        color: Colors.black,
        margin: EdgeInsets.all(15),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 35.0,
            ),
            Text(
              'हमारी यात्रा...... अब तक',
              style: TextStyle(
                  fontSize: 30,
                  color: Colors.white
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Container(
              color: Colors.black,
              margin: EdgeInsets.all(20),
              alignment: Alignment.center,
              child: Column(
                children: <Widget>[
                  Text(
                    '--> हमारी सोसाइटी में शुरू से ही सफाई, बिजली, लिफ्ट और अन्य मूलभूत सुविधाओं के प्रति मेंटेनन्स उदासीन रहा है। जिसके संदर्भ में परिवार के सदस्यों द्वारा अनेकों बार शिकायत करने के बाद भी स्थिति में सुधार नहीं हुआ।  तब हमारी टीम ने 11 लोगों की वर्किंग टीम का गठन किया जिनके निरंतर प्रयास से मेंटेनन्स टीम के द्वारा इनमे से काफी मुद्दों पर सुधार में सफलता पायी एवं काफी हद तक ये सुविधाएँ ठीक कराईI',
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.white
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    '--> कोरोना वायरस के समय हुए लॉकडाउन में जब हम सब "वर्क फ्रॉम होम" कर रहे थे और हमारे बच्चों ने ऑनलाइन क्लास में अपनी पढाई शुरू की तो हम सबों को एक अच्छे इंटरनेट प्रोवाइडर की आवश्यकता महसूस हुई फिर हमारी टीम के अथक प्रयासों के द्वारा एयरटेल को अपनी सोसाइटी में इंटरनेट की सुविधा के लिए राजी किया और आज भी हमारी टीम एयरटेल के साथ सोसाइटी में इण्टरकॉम की सुविधा बहाल करने के लिए निरंतर प्रयासरत है जिसके लिए एयरटेल अधिकारी से हमारी बातचीत निर्णायक दौर पर पहुँच चुकी है।',
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.white
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    '--> हमारी टीम ने सोसाइटी के लोगों के सहयोग से त्यौहार एवं अन्य कार्यक्रम का सफल आयोजन किया जिसमे गाँधी जयंती के दिन का सफाई कार्यक्रम एवम भव्य दुर्गा पूजा का आयोजन मुख्य रहा I 2 अक्टूबर, गाँधी जयंती, को हमारी टीम ने सोसाइटी के सभी लोगों के सहयोग से  हर टावर एवं कॉमन एरिया की  सफाई की तथा टावर के हर हिस्से में वृक्षारोपण का कार्यक्रम किया I टीम ने भव्य दुर्गा-पूजा का भी आयोजन आपके सहयोग से किया। लोगो से मिले फीडबैक के अनुसार ये आस-पास के क्षेत्र की सबसे भव्यतम दुर्गा-पूजा थी जिसने अर्बन होम्स की एक नई पहचान दी हैं।',
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.white
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    '--> आप सभी के सहयोग से हीं हमारी टीम ने Sub-Team बनाकर संबद्ध टॉवरों के सीढ़ी के प्रवेश द्वार पर लोहे के गेट लगवाए जिससे कुत्तों का फ्लोर पर जाना रोका जा सका हैI  सोसाइटी में फर्स्ट ऐड बॉक्स एवम व्हील चेयर की व्यवस्था भी की गईI पुनः यह कार्य आपके सहयोग से ही किया गया।',
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.white
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              ' हमारी टीम पुनः दोहराती है कि ये सब कार्य बिना आपके सहयोग से संभव नहीं थे और उम्मीद करती है कि आगे भी आपका सहयोग हमें मिलता रहेगा और आप यूँ हीं हम सबों को कार्य करने के लिए प्रेरित करते रहेंगे। ',
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.white
              ),
            ),
          ],
        ),
      ),
    ),
    SingleChildScrollView(
      child: Container(
        color: Colors.black,
        margin: EdgeInsets.all(15),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 35.0,
            ),
            Text(
              'Manifesto',
              style: TextStyle(
                  fontSize: 30,
                  color: Colors.white
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              '1.	मूलभूत सुविधाएं -',
              style: TextStyle(
                  fontSize: 30,
                  color: Colors.white
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            Text(
              '	जब से रहने के लिए सोसाइटी कल्चर का प्रारंभ हुआ हैं, तभी से इसमें घर लेते समय जो बाते मुख्य रूप से महत्व रखती हैं वो हैं –',
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.white
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Container(
              color: Colors.black,
              margin: EdgeInsets.all(20),
              alignment: Alignment.center,
              child: Column(
                children: <Widget>[
                  Text(
                    '1.1:  सुरक्षा – अपने और अपने परिवार की सुरक्षा सबसे प्रथम हैं, हमारी टीम सभी टावर के आगमन/निकास द्वारों पर गार्ड्स की तैनाती तय करेगी, सभी सवेंदनशील जगहों पर खासकर रात में गनमैन और गार्ड्स की तैनाती तय होगी। दिन में कम से कम दो महिला गार्ड्स की तैनाती होगी।',
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.white
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    '1.1.(a) :  ऊपर के बिंदु से सम्बन्धित सभी संवेदनशील जगहों को CCTV के अंतर्गत लाया जायेगा और लिफ्ट एवं कॉरिडोर में भी CCTV लगाने का प्रयास किया जायेगा। रेजिडेंस की संख्या देखते हुए पुलिस गस्त के लिए प्रयास किया जायेगा।  ',
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.white
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    '1.2 : सफाई दूसरी ऐसी प्राथमिकता है जो की अति-महत्वपूर्ण हैं। हमारी टीम सभी टावर एवं कॉमन एरिया की नियमित सफाई कुशल कर्मचारियों के द्वारा सुनिश्चित करेगी। ओवरहेड टैंक की सफाई मशीन एवं तकनीक के द्वारा हर ३ महीने में कराई जाएगी।',
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.white
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    '1.3 : बिजली एवं पानी  -	बिजली एवं पानी की निर्बाध आपूर्ति के लिए दिन और रात दोनों समय कम से कम एक प्लम्बर और एक बिजली मिस्त्री की व्यवस्था रखी जाएगी। बिजली व्यवस्था के ऑडिट के बाद कॉमन एरिया के डेली रेट को कम करने का प्रयास किया जायेगा। STP का पानी जो की M, N टावर के पीछे जमा किया जाता हैं। जिससे वह दलदल हो गया हैं, उसे रोका रोका जायेगा और STP के पानी की नियमित रूप से निरीक्षण किया जायेगा ताकि गंदा पानी वाशरूम में न आये।',
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.white
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    '1.3.(a) : कॉरिडोर एवं कॉमन एरिया की सभी लाइट्स की नियमित जाँच होगी और सभी ख़राब लाइट्स को बदला जायेगा।',
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.white
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30.0,
            ),

            Text(
              '2.	Club और Gym, Swimming Pool  - ',
              style: TextStyle(
                  fontSize: 30,
                  color: Colors.white
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Container(
              color: Colors.black,
              margin: EdgeInsets.all(20),
              alignment: Alignment.center,
              child: Column(
                children: <Widget>[
                  Text(
                    '2.1: Club -  Club और Gym एरिया ऐसी जगह होती हैं जो सिर्फ सोसाइटी में उपलब्ध होती हैं। और जहाँ रेजिडेंस अपना खाली समय विभिन्न कार्यकलापों में बिताते हैं। इसलिए Club, Pool और Gym एरिया हमारे टीम के अति-महत्वपूर्ण विषय है।',
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.white
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    '2.1.(a) : Club: हमारी टीम Club के हॉल में टेबल-टेनिस, कैरम एवं शतरंज की व्यवस्था करेगी ताकि क्लब का सम्पूर्ण सदुपयोग हो सके।',
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.white
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    '2.1.(b) : Gym: हमारा Gym वर्तमान अवस्था में बहुत ही प्रारंभिक अवस्था का हैं और वर्कआउट के प्रेमी लोगो के लिए बहुत काम का नहीं हैं, हमारी टीम कुछ अच्छे उपकरणों का प्रबंध करेगी ताकि Gym का इस्तेमाल रुचिकर हो सके।',
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.white
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    '2.1.(c) : Pool: Pool को नियमित सफाई एवं fencing का काम किया जायेगा।',
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.white
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    '2.1.(d) : Club का Kids एरिया - हमारी टीम Club का Kids एरिया में बच्चों के लिए एक मिनी लाइब्रेरी बनाने का प्रस्ताव रखती हैं ताकि खाली समय में हमारे बच्चे ज्ञानबर्धक एवं मनोरंजक किताबे पढ़ सके।',
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.white
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    '2.1.(e) : ऊपर के बिंदुओं के अलावा हमारी टीम Swimming, Skating के लिए निपुण प्रशिक्षको को बुलाएगी ताकि हमारे बच्चे इन खेलो में अपना skill बना और बढ़ा सके।',
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.white
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30.0,
            ),

            Text(
              '3.	हरित क्षेत्रों का विकास एवं रख-रखाव –',
              style: TextStyle(
                  fontSize: 30,
                  color: Colors.white
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            Text(
              '	हरित क्षेत्र किसी भी सोसाइटी की शोभा होती हैं और हमारा अर्बन होम्स इस मामले में काफी समृद्ध हैं।',
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.white
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Container(
              color: Colors.black,
              margin: EdgeInsets.all(20),
              alignment: Alignment.center,
              child: Column(
                children: <Widget>[
                  Text(
                    '3.1 : हमारी टीम को यह ज्ञात हुआ था की बिल्डर M, N टावर के पीछे के हरित क्षेत्र को विकसित नहीं करना चाह रहा हैं। हमारी टीम इसका विरोध करेगी और प्रस्तावित हरित क्षेत्र के विकास को सुनिश्चित करेगी।',
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.white
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    '3.2 : अर्बन होम्स के सभी हरित क्षेत्र के रख रखाव की पूरी व्यवस्था की जाएगी और नए वृक्षरोपण को बढ़ावा दिया जायेगा।',
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.white
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30.0,
            ),

            Text(
              '4. किरायेदारों और पालतू जानवरों के लिए दिशा निर्देश  -',
              style: TextStyle(
                  fontSize: 30,
                  color: Colors.white
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Container(
              color: Colors.black,
              margin: EdgeInsets.all(20),
              alignment: Alignment.center,
              child: Column(
                children: <Widget>[
                  Text(
                    '4.1 : हमारी टीम यह समझती है की कई ओनर्स ने यहाँ फ्लैट निवेश के उदेस्य से लिया हैं और वो अपना फ्लैट किराये पर देना चाहेंगे, इसलिए हमारी टीम वैसे सभी फ्लैट ओनर्स के साथ मिलकर एक ऐसी निति बनाएगी जिसमे वैसे फ्लैट ओनर्स एवं यहाँ के निवासी दोनों के हितो में टकराव की स्थिति ना बने।',
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.white
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30.0,
            ),

            Text(
              '4.2 : पालतू जानवर रखने के दिशा निर्देश –',
              style: TextStyle(
                  fontSize: 30,
                  color: Colors.white
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Container(
              color: Colors.black,
              margin: EdgeInsets.all(20),
              alignment: Alignment.center,
              child: Column(
                children: <Widget>[
                  Text(
                    '4.1 :  हमारी टीम सभी पशु प्रेमियों के साथ मिलकर दिशा निर्देश बनाएगी ताकि ये पशु किसी की परेशानी नहीं बल्कि हर्ष का विषय बन सके। ',
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.white
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30.0,
            ),

            Text(
              '5. :  स्कुल बस स्टॉप के पास शेड की व्यवस्था –',
              style: TextStyle(
                  fontSize: 30,
                  color: Colors.white
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Container(
              color: Colors.black,
              margin: EdgeInsets.all(20),
              alignment: Alignment.center,
              child: Column(
                children: <Widget>[
                  Text(
                    ' हमारी टीम को महिलाओं की तरफ से यह सुझाव मिला की अर्बन के गेट के पास स्कूल बस स्टॉप के पास एक शेड की व्यवस्था हो ताकि बच्चो को छोड़ने और लेने जाते समय महिलाओ को परेशानी ना हो। हमारी टीम इस सुझाव का सम्मान करती है और इसकी व्यवस्था करेगी।',
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.white
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30.0,
            ),

            Text(
              '6. : बैठने की समुचित व्यवस्था –',
              style: TextStyle(
                  fontSize: 30,
                  color: Colors.white
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Container(
              color: Colors.black,
              margin: EdgeInsets.all(20),
              alignment: Alignment.center,
              child: Column(
                children: <Widget>[
                  Text(
                    ' अभी सिर्फ एम्पीथियटर एरिया में ही बैठने की व्यवस्था है, हमारी टीम कुछ और ऐसी जगहों को चिन्हित क्र बैठने की व्यवस्था करेगी ताकि हमारे Senior Citizens को हम थोड़ी और सहूलियत दे पाये।',
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.white
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30.0,
            ),

            Text(
              '7. : लिफ्ट एवं फायर-',
              style: TextStyle(
                  fontSize: 30,
                  color: Colors.white
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Container(
              color: Colors.black,
              margin: EdgeInsets.all(20),
              alignment: Alignment.center,
              child: Column(
                children: <Widget>[
                  Text(
                    ' हमारी टीम लिफ्ट एवं फायर संसाधनों का नियमित ऑडिट कराएगी और नियमित रूप से ड्रिल कराकर इसके सही संचालन के लिए जागरूकता लाएगी।',
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.white
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30.0,
            ),

            Text(
              '8. : सुरक्षाकर्मी एवं सफाई कर्मचारियों के लिए सुविधाएं –',
              style: TextStyle(
                  fontSize: 30,
                  color: Colors.white
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Container(
              color: Colors.black,
              margin: EdgeInsets.all(20),
              alignment: Alignment.center,
              child: Column(
                children: <Widget>[
                  Text(
                    ' सुरक्षाकर्मी एवं सफाई कर्मचारी हमारी सुविधा के लिए हैं। हमारी टीम न सिर्फ अर्बन वासियो के लिए बल्कि इनके लिए भी सवेंदनशील हैं। हमारी टीम इन्हे मुलभुत सुविधाएं जैसे की पीने का पानी और शौचालय की व्यवस्था करेगी।',
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.white
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30.0,
            ),

            Text(
              '	इन सभी विषयों के अलावा दो और विषय हमारी टीम के विज़न में प्रमुखता से होंगे: -',
              style: TextStyle(
                  fontSize: 30,
                  color: Colors.white
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Container(
              color: Colors.black,
              margin: EdgeInsets.all(20),
              alignment: Alignment.center,
              child: Column(
                children: <Widget>[
                  Text(
                    '(i)	पार्किंग - हम सभी जानते हैं कि हमारे अर्बन होम्स में पार्किंग के समस्या होगी इसके लिए हमारी टीम बिल्डर के साथ इस समस्या के हल के लिए सभी संभव प्रयास करेगी।',
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.white
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Text(
                    '(ii)	मंदिर - हमारी टीम बिल्डर से मंदिर के लिए अर्बन होम्स में ही जगह की मांग करेगी और अपने तर्कों के द्वारा इसकी पूर्ति के सभी संभव प्रयास करेगी।',
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.white
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            Text(
              'Uraban Parivar Sewa Samiti इन सभी बिंदुओं के कार्यान्वयन के लिए कटिबद्ध हैं और हम समय-समय पर इस सम्बंधित जानकारी आप सबको उपलब्ध कराते रहेंगे।',
              style: TextStyle(
                  fontSize: 15,
                  color: Colors.white
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              'आपका सहयोग, हमारा विश्वास…….. उत्कृष्ण अर्बन परिवार',
              style: TextStyle(
                  fontSize: 15,
                  color: Colors.white
              ),
            ),
            SizedBox(
              height: 30.0,
            ),

          ],
        ),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: _channel != null && _currentIndex ==1
          ? NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification scrollDetails) {
                if (!_isLoading &&
                    _channel.videos.length != int.parse(_channel.videoCount) &&
                    scrollDetails.metrics.pixels ==
                        scrollDetails.metrics.maxScrollExtent) {
                  _loadMoreVideos();
                }
                return false;
              },
              child: ListView.builder(
                itemCount: 1 + _channel.videos.length,
                itemBuilder: (BuildContext context, int index) {
                  if (index == 0) {
                    return _buildProfileInfo();
                  }
                  Video video = _channel.videos[index - 1];
                  return _buildVideo(video);
                },
              ),
            )
          : _channel != null && _currentIndex == 0 ?
          WebviewScaffold(
            initialChild: tabs[0],
            url: "https://drive.google.com/drive/folders/14gFmT44-jwSWPjCh-EGnKDWt91wx_r7V?usp=sharing",
          )
          : _channel != null && _currentIndex == 2 ?
      Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            _buildProfileInfo(),
            carouselSlider = CarouselSlider(
              height: 400.0,
              initialPage: 0,
              enlargeCenterPage: true,
              autoPlay: true,
              reverse: false,
              enableInfiniteScroll: true,
              autoPlayInterval: Duration(seconds: 2),
              autoPlayAnimationDuration: Duration(milliseconds: 2000),
              pauseAutoPlayOnTouch: Duration(seconds: 10),
              scrollDirection: Axis.horizontal,
              onPageChanged: (index) {
                setState(() {
                  _current = index;
                });
              },
              items: imgList.map((imgUrl) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 10.0),
                      decoration: BoxDecoration(
                        color: Colors.black,
                      ),
                      child: Image(image: AssetImage(imgUrl)),
                    );
                  },
                );
              }).toList(),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: map<Widget>(imgList, (index, url) {
                return Container(
                  width: 10.0,
                  height: 10.0,
                  margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _current == index ? Colors.redAccent : Colors.green,
                  ),
                );
              }),
            ),
            SizedBox(
              height: 20.0,
            ),
            Text('Our Team',style: TextStyle(fontSize: 50,color: Colors.deepPurple),),
          ],
        ),
      ): tabs[_currentIndex],
      bottomNavigationBar: CurvedNavigationBar(
        color: Colors.white,
        backgroundColor: Colors.black,
        buttonBackgroundColor: Colors.white,
        height: 50,
        items: <Widget>[
          Icon(Icons.photo_library,size: 20,color: Colors.black),
          Icon(Icons.video_library,size: 20,color: Colors.black),
          Icon(Icons.person,size: 20,color: Colors.black),
          Icon(Icons.assignment,size: 20,color: Colors.black),
          Icon(Icons.account_balance_wallet,size: 20,color: Colors.black)
        ],
        animationDuration: Duration(
          milliseconds: 200,
        ),
        index: _currentIndex,
        animationCurve: Curves.bounceInOut,
        onTap: (index){
          setState(() {
            if(index == 0){
              _currentIndex = index;
            }
            if(index == 1){
              _currentIndex = index;
            }
            if(index == 2){
              _currentIndex = index;
            }
            if(index == 3){
              _currentIndex = index;
            }
            if(index == 4){
              _currentIndex = index;
            }
          });
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SendMail()),
          );
        },
        child: Icon(Icons.message),
        backgroundColor: Colors.green,
      ),
    );
  }

  goToPrevious() {
    carouselSlider.previousPage(
        duration: Duration(milliseconds: 300), curve: Curves.ease);
  }

  goToNext() {
    carouselSlider.nextPage(
        duration: Duration(milliseconds: 300), curve: Curves.decelerate);
  }
}

