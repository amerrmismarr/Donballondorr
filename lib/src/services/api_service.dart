import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter/material.dart';
import 'package:Donballondor/src/models/prediction.dart';




class ApiService {

final _fixtures = BehaviorSubject<List<dynamic>>();
final _date = BehaviorSubject<String>();
Stream<List<dynamic>> get fixtures => _fixtures.stream;
Stream<String> get date => _date.stream;









dispose() {
    _fixtures.close();
    _date.close();
  }

List<dynamic> data;
Future getFixtures(String date, BuildContext context) async {


   
    

    _fixtures.sink.add(null);

    
   /*HttpClient client = new HttpClient();
   client.badCertificateCallback = ((
     X509Certificate cert, String host,
     int port
   ) => true);*/
    

    var response = await http.get(Uri.parse('https://api-football-v1.p.rapidapi.com/v2/fixtures/date/' + date), headers: {
      'Accept': 'application/json',
      "x-rapidapi-host": "api-football-v1.p.rapidapi.com",
      "x-rapidapi-key": "9277c6f840mshffcaa155ce6daf9p1f43c7jsnff99eae70a7c",
    });

    if (response.statusCode == 200) {
      Map<String, dynamic> map = jsonDecode(response.body);
      
      data = map['api']['fixtures'];

      data.forEach((fixture) {
        
       
        fixture['homeTeamPrediction'] = ' ';
        fixture['awayTeamPrediction'] = ' ';
        /*if(fixture['goalsHomeTeam'] == null){
          fixture['goalsHomeTeam'] = 0;
        }
        if(fixture['goalsAwayTeam'] == null){
          fixture['goalsAwayTeam'] = 0;
        }*/
        
        
        if(fixture['league']['country'] == 'World' && fixture['league']['name'] == 'World Cup' ){
          fixture['popularity'] = '001';
        } else if (fixture['league']['country'] == 'World' && fixture['league']['name'] == 'World Cup - Qualification Europe') {
          fixture['popularity'] = '002';
        } else if (fixture['league']['country'] == 'World' && fixture['league']['name'] == 'World Cup - Qualification South America'){
          fixture['popularity'] = '003';
        } else if(fixture['league']['country'] == 'World' && fixture['league']['name'] == 'World Cup - Qualification Asia'){
          fixture['popularity'] = '004';
        } else if(fixture['league']['country'] == 'World' && fixture['league']['name'] == 'World Cup - Qualification Africa'){
          fixture['popularity'] = '005';
        } else if(fixture['league']['country'] == 'World' && fixture['league']['name'] == 'World Cup - Qualification CONCACAF'){
          fixture['popularity'] = '006';
        } else if(fixture['league']['country'] == 'World' && fixture['league']['name'] == 'Euro Championship'){
          fixture['popularity'] = '007';
        } else if(fixture['league']['country'] == 'World' && fixture['league']['name'] == 'UEFA Nations League'){
          fixture['popularity'] = '008';
        } else if(fixture['league']['country'] == 'World' && fixture['league']['name'] == 'Copa America'){
          fixture['popularity'] = '009';
        } else if(fixture['league']['country'] == 'World' && fixture['league']['name'] == 'Asian Cup'){
          fixture['popularity'] = '010';
        } else if(fixture['league']['country'] == 'World' && fixture['league']['name'] == 'Asian Cup - Qualification'){
          fixture['popularity'] = '011';
        } else if(fixture['league']['country'] == 'World' && fixture['league']['name'] == 'Africa Cup of Nations'){
          fixture['popularity'] = '012';
        } else if(fixture['league']['country'] == 'World' && fixture['league']['name'] == 'Africa Cup of Nations - Qualification'){
          fixture['popularity'] = '013';
        }  else if(fixture['league']['country'] == 'World' && fixture['league']['name'] == 'African Nations Championship'){
          fixture['popularity'] = '014';
        } else if(fixture['league']['country'] == 'World' && fixture['league']['name'] == 'CONCACAF Gold Cup'){
          fixture['popularity'] = '015';
        } else if(fixture['league']['country'] == 'World' && fixture['league']['name'] == 'Confederations Cup'){
          fixture['popularity'] = '016';
        } else if(fixture['league']['country'] == 'World' && fixture['league']['name'] == 'FIFA Club World Cup'){
          fixture['popularity'] = '017';
        } else if(fixture['league']['country'] == 'World' && fixture['league']['name'] == 'Olympics Men'){
          fixture['popularity'] = '018';
        } else if(fixture['league']['country'] == 'World' && fixture['league']['name'] == 'UEFA Champions League'){
          fixture['popularity'] = '019';
        } else if(fixture['league']['country'] == 'World' && fixture['league']['name'] == 'UEFA Europa League'){
          fixture['popularity'] = '020';
        } else if(fixture['league']['country'] == 'World' && fixture['league']['name'] == 'UEFA Super Cup'){
          fixture['popularity'] = '021';
        } else if(fixture['league']['country'] == 'England' && fixture['league']['name'] == 'Premier League'){
          fixture['popularity'] = '022';
        } else if(fixture['league']['country'] == 'Spain' && fixture['league']['name'] == 'Primera Division'){
          fixture['popularity'] = '023';
        } else if(fixture['league']['country'] == 'Italy' && fixture['league']['name'] == 'Serie A'){
          fixture['popularity'] = '024';
        } else if(fixture['league']['country'] == 'Germany' && fixture['league']['name'] == 'Bundesliga 1'){
          fixture['popularity'] = '025';
        } else if(fixture['league']['country'] == 'France' && fixture['league']['name'] == 'Ligue 1'){
          fixture['popularity'] = '026';
        } else if(fixture['league']['country'] == 'England' && fixture['league']['name'] == 'FA Cup'){
          fixture['popularity'] = '027';
        } else if(fixture['league']['country'] == 'England' && fixture['league']['name'] == 'League Cup'){
          fixture['popularity'] = '028';
        } else if(fixture['league']['country'] == 'England' && fixture['league']['name'] == 'Community Shield'){
          fixture['popularity'] = '029';
        } else if(fixture['league']['country'] == 'Spain' && fixture['league']['name'] == 'Copa del Rey'){
          fixture['popularity'] = '030';
        } else if(fixture['league']['country'] == 'Spain' && fixture['league']['name'] == 'Super Cup'){
          fixture['popularity'] = '031';
        } else if(fixture['league']['country'] == 'Italy' && fixture['league']['name'] == 'Coppa Italia'){
          fixture['popularity'] = '032';
        } else if(fixture['league']['country'] == 'Italy' && fixture['league']['name'] == 'Super Cup'){
          fixture['popularity'] = '033';
        } else if(fixture['league']['country'] == 'Germany' && fixture['league']['name'] == 'DFB Pokal'){
          fixture['popularity'] = '034';
        } else if(fixture['league']['country'] == 'France' && fixture['league']['name'] == 'Coupe de France'){
          fixture['popularity'] = '035';
        } else if(fixture['league']['country'] == 'France' && fixture['league']['name'] == 'Coupe de la Ligue'){
          fixture['popularity'] = '036';
        } else if(fixture['league']['country'] == 'France' && fixture['league']['name'] == 'Trophée des Champions'){
          fixture['popularity'] = '037';
        } else if(fixture['league']['country'] == 'World' && fixture['league']['name'] == 'CONMEBOL Libertadores'){
          fixture['popularity'] = '038';
        } else if(fixture['league']['country'] == 'World' && fixture['league']['name'] == 'CONMEBOL Sudamericana'){
          fixture['popularity'] = '039';
        } else if(fixture['league']['country'] == 'World' && fixture['league']['name'] == 'CONMEBOL Recopa'){
          fixture['popularity'] = '040';
        } else if(fixture['league']['country'] == 'Brazil' && fixture['league']['name'] == 'Serie A'){
          fixture['popularity'] = '041';
        } else if(fixture['league']['country'] == 'Argentina' && fixture['league']['name'] == 'Primera Division'){
          fixture['popularity'] = '042';
        } else if(fixture['league']['country'] == 'Netherlands' && fixture['league']['name'] == 'Eredivisie'){
          fixture['popularity'] = '043';
        } else if(fixture['league']['country'] == 'Portugal' && fixture['league']['name'] == 'Primeira Liga'){
          fixture['popularity'] = '044';
        } else if(fixture['league']['country'] == 'England' && fixture['league']['name'] == 'Championship'){
          fixture['popularity'] = '045';
        } else if(fixture['league']['country'] == 'World' && fixture['league']['name'] == 'Friendlies'){
          fixture['popularity'] = '046';
        } else if(fixture['league']['country'] == 'Albania' && fixture['league']['name'] == 'Superliga'){
          fixture['popularity'] = '047';
        } else if(fixture['league']['country'] == 'Albania' && fixture['league']['name'] == '1st Division'){
          fixture['popularity'] = '048';
        } /*else if(fixture['league']['country'] == 'Albania' && fixture['league']['name'] == '2nd Division - Group A'){
          fixture['popularity'] = '049';
        } else if(fixture['league']['country'] == 'Albania' && fixture['league']['name'] == '2nd Division - Group B'){
          fixture['popularity'] = '050';
        }*/ else if(fixture['league']['country'] == 'Algeria' && fixture['league']['name'] == 'Super Cup'){
          fixture['popularity'] = '051';
        } else if(fixture['league']['country'] == 'Algeria' && fixture['league']['name'] == 'Coupe Nationale'){
          fixture['popularity'] = '052';
        } else if(fixture['league']['country'] == 'Algeria' && fixture['league']['name'] == 'Ligue 1'){
          fixture['popularity'] = '053';
        } /*else if(fixture['league']['country'] == 'Algeria' && fixture['league']['name'] == 'Ligue 2'){
          fixture['popularity'] = '054';
        } else if(fixture['league']['country'] == 'Algeria' && fixture['league']['name'] == 'U21 League 1'){
          fixture['popularity'] = '055';
        }*/ else if(fixture['league']['country'] == 'Andorra' && fixture['league']['name'] == '1a Divisió'){
          fixture['popularity'] = '056';
        } else if(fixture['league']['country'] == 'Andorra' && fixture['league']['name'] == 'Copa Constitució'){
          fixture['popularity'] = '057';
        } /*else if(fixture['league']['country'] == 'Andorra' && fixture['league']['name'] == '2a Divisió'){
          fixture['popularity'] = '058';
        } else if(fixture['league']['country'] == 'Andorra' && fixture['league']['name'] == '2a Divisió'){
          fixture['popularity'] = '059';
        } */ else if(fixture['league']['country'] == 'Angola' && fixture['league']['name'] == 'Girabola'){
          fixture['popularity'] = '060';
        } else if(fixture['league']['country'] == 'Argentina' && fixture['league']['name'] == 'Copa Argentina'){
          fixture['popularity'] = '061';
        } else if(fixture['league']['country'] == 'Argentina' && fixture['league']['name'] == 'Trofeo de Campeones de la Superliga'){
          fixture['popularity'] = '062';
        } else if(fixture['league']['country'] == 'Argentina' && fixture['league']['name'] == 'Primera B Metropolitana'){
          fixture['popularity'] = '063';
        } else if(fixture['league']['country'] == 'Argentina' && fixture['league']['name'] == 'Primera B Nacional'){
          fixture['popularity'] = '064';
        } /*else if(fixture['league']['country'] == 'Argentina' && fixture['league']['name'] == 'Primera C'){
          fixture['popularity'] = '065';
        } else if(fixture['league']['country'] == 'Argentina' && fixture['league']['name'] == 'Primera D'){
          fixture['popularity'] = '066';
        } else if(fixture['league']['country'] == 'Argentina' && fixture['league']['name'] == 'Tomeo Federal A'){
          fixture['popularity'] = '067';
        } */ else if(fixture['league']['country'] == 'Armenia' && fixture['league']['name'] == 'Premier League'){
          fixture['popularity'] = '068';
        } else if(fixture['league']['country'] == 'Armenia' && fixture['league']['name'] == 'First League'){
          fixture['popularity'] = '069';
        } else if(fixture['league']['country'] == 'Aruba' && fixture['league']['name'] == 'Division di Honor'){
          fixture['popularity'] = '070';
        } else if(fixture['league']['country'] == 'Australia' && fixture['league']['name'] == 'National Premier Leagues'){
          fixture['popularity'] = '071';
        } /*else if(fixture['league']['country'] == 'Australia' && fixture['league']['name'] == 'Northern Territory Premier League'){
          fixture['popularity'] = '072';
        } else if(fixture['league']['country'] == 'Australia' && fixture['league']['name'] == 'South Australia NPL'){
          fixture['popularity'] = '073';
        }*/ else if(fixture['league']['country'] == 'Australia' && fixture['league']['name'] == 'Victoria NPL'){
          fixture['popularity'] = '074';
        } /*else if(fixture['league']['country'] == 'Australia' && fixture['league']['name'] == 'Western Australia NPL'){
          fixture['popularity'] = '075';
        } */else if(fixture['league']['country'] == 'Australia' && fixture['league']['name'] == 'W-League'){
          fixture['popularity'] = '076';
        } else if(fixture['league']['country'] == 'Australia' && fixture['league']['name'] == 'A-League'){
          fixture['popularity'] = '077';
        } else if(fixture['league']['country'] == 'Australia' && fixture['league']['name'] == 'Brisbane Premier League'){
          fixture['popularity'] = '078';
        } else if(fixture['league']['country'] == 'Australia' && fixture['league']['name'] == 'Queensland NPL'){
          fixture['popularity'] = '079';
        } /*else if(fixture['league']['country'] == 'Australia' && fixture['league']['name'] == 'Northern NSW NPL'){
          fixture['popularity'] = '080';
        }*/ else if(fixture['league']['country'] == 'Australia' && fixture['league']['name'] == 'New South Wales NPL'){
          fixture['popularity'] = '081';
        } else if(fixture['league']['country'] == 'Austria' && fixture['league']['name'] == 'Cup'){
          fixture['popularity'] = '082';
        } else if(fixture['league']['country'] == 'Austria' && fixture['league']['name'] == 'Erste Liga'){
          fixture['popularity'] = '083';
        } /*else if(fixture['league']['country'] == 'Austria' && fixture['league']['name'] == 'Landesliga - Salzburg'){
          fixture['popularity'] = '084';
        } else if(fixture['league']['country'] == 'Austria' && fixture['league']['name'] == 'Landesliga - Steiermark'){
          fixture['popularity'] = '085';
        } else if(fixture['league']['country'] == 'Austria' && fixture['league']['name'] == 'Tipp3 Bundesliga'){
          fixture['popularity'] = '086';
        } else if(fixture['league']['country'] == 'Austria' && fixture['league']['name'] == 'Landesliga - Wien'){
          fixture['popularity'] = '087';
        } else if(fixture['league']['country'] == 'Austria' && fixture['league']['name'] == 'Landesliga - Vorarlbergliga'){
          fixture['popularity'] = '088';
        } else if(fixture['league']['country'] == 'Austria' && fixture['league']['name'] == 'LandesLiga - Tirol'){
          fixture['popularity'] = '089';
        } else if(fixture['league']['country'] == 'Austria' && fixture['league']['name'] == 'Regionalliga - Ost'){
          fixture['popularity'] = '090';
        } else if(fixture['league']['country'] == 'Austria' && fixture['league']['name'] == 'Regionalliga - Mitte'){
          fixture['popularity'] = '091';
        } else if(fixture['league']['country'] == 'Austria' && fixture['league']['name'] == 'Regionalliga - West'){
          fixture['popularity'] = '092';
        } else if(fixture['league']['country'] == 'Austria' && fixture['league']['name'] == 'Landesliga - Burgenland'){
          fixture['popularity'] = '093';
        } else if(fixture['league']['country'] == 'Austria' && fixture['league']['name'] == 'Landesliga - Karnten'){
          fixture['popularity'] = '094';
        } else if(fixture['league']['country'] == 'Austria' && fixture['league']['name'] == 'Landesliga - Niederosterreich'){
          fixture['popularity'] = '095';
        } else if(fixture['league']['country'] == 'Austria' && fixture['league']['name'] == 'Landesliga - Oberosterreich'){
          fixture['popularity'] = '096';
        } */ else if(fixture['league']['country'] == 'Azerbaidjan' && fixture['league']['name'] == 'Cup'){
          fixture['popularity'] = '097';
        } else if(fixture['league']['country'] == 'Azerbaidjan' && fixture['league']['name'] == 'Premyer Liqa'){
          fixture['popularity'] = '098';
        } /* else if(fixture['league']['country'] == 'Azerbaidjan' && fixture['league']['name'] == 'Birinci Dasta'){
          fixture['popularity'] = '099';
        } */else if(fixture['league']['country'] == 'Bahrain' && fixture['league']['name'] == 'Premier League'){
          fixture['popularity'] = '100';
        } else if(fixture['league']['country'] == 'Bahrain' && fixture['league']['name'] == 'King\'s Cup'){
          fixture['popularity'] = '101';
        } else if(fixture['league']['country'] == 'Bangladesh' && fixture['league']['name'] == 'Premier League'){
          fixture['popularity'] = '102';
        } else if(fixture['league']['country'] == 'Barbados' && fixture['league']['name'] == 'Premier League'){
          fixture['popularity'] = '103';
        } else if(fixture['league']['country'] == 'Belarus' && fixture['league']['name'] == 'Coppa'){
          fixture['popularity'] = '104';
        } else if(fixture['league']['country'] == 'Belarus' && fixture['league']['name'] == '1. Division'){
          fixture['popularity'] = '105';
        } /*else if(fixture['league']['country'] == 'Belarus' && fixture['league']['name'] == '2. Division'){
          fixture['popularity'] = '106';
        } else if(fixture['league']['country'] == 'Belarus' && fixture['league']['name'] == 'Vysshaya Liga'){
          fixture['popularity'] = '107';
        } */else if(fixture['league']['country'] == 'Belgium' && fixture['league']['name'] == 'Super Cup'){
          fixture['popularity'] = '108';
        } else if(fixture['league']['country'] == 'Belgium' && fixture['league']['name'] == 'Cup'){
          fixture['popularity'] = '109';
        } else if(fixture['league']['country'] == 'Belgium' && fixture['league']['name'] == 'Reserve Pro League'){
          fixture['popularity'] = '110';
        } else if(fixture['league']['country'] == 'Belgium' && fixture['league']['name'] == 'Jupiler Pro League'){
          fixture['popularity'] = '111';
        } /*else if(fixture['league']['country'] == 'Belgium' && fixture['league']['name'] == 'Provincial - Liege'){
          fixture['popularity'] = '112';
        } else if(fixture['league']['country'] == 'Belgium' && fixture['league']['name'] == 'Provincial - Antwerpen'){
          fixture['popularity'] = '113';
        } else if(fixture['league']['country'] == 'Belgium' && fixture['league']['name'] == 'Provincial - Brabant VFV'){
          fixture['popularity'] = '114';
        } else if(fixture['league']['country'] == 'Belgium' && fixture['league']['name'] == 'Provincial - Hainaut'){
          fixture['popularity'] = '115';
        } else if(fixture['league']['country'] == 'Belgium' && fixture['league']['name'] == 'Provincial - Limburg'){
          fixture['popularity'] = '116';
        } else if(fixture['league']['country'] == 'Belgium' && fixture['league']['name'] == 'Provincial - Luxembourg'){
          fixture['popularity'] = '117';
        } else if(fixture['league']['country'] == 'Belgium' && fixture['league']['name'] == 'Provincial - Namur'){
          fixture['popularity'] = '118';
        } else if(fixture['league']['country'] == 'Belgium' && fixture['league']['name'] == 'Provincial - Oost-Vlaanderen'){
          fixture['popularity'] = '119';
        } else if(fixture['league']['country'] == 'Belgium' && fixture['league']['name'] == 'Provincial - West-Vlaanderen'){
          fixture['popularity'] = '120';
        } else if(fixture['league']['country'] == 'Belgium' && fixture['league']['name'] == '2e Klasse'){
          fixture['popularity'] = '121';
        } else if(fixture['league']['country'] == 'Belgium' && fixture['league']['name'] == 'First Amateur Division'){
          fixture['popularity'] = '122';
        } else if(fixture['league']['country'] == 'Belgium' && fixture['league']['name'] == 'Second Amateur Division - ACFF'){
          fixture['popularity'] = '123';
        } else if(fixture['league']['country'] == 'Belgium' && fixture['league']['name'] == 'Second Amateur Division - VFV A'){
          fixture['popularity'] = '124';
        } else if(fixture['league']['country'] == 'Belgium' && fixture['league']['name'] == 'Second Amateur Division - VFV B'){
          fixture['popularity'] = '125';
        } else if(fixture['league']['country'] == 'Belgium' && fixture['league']['name'] == 'Third Amateur Division - VFV A'){
          fixture['popularity'] = '126';
        } else if(fixture['league']['country'] == 'Belgium' && fixture['league']['name'] == 'Third Amateur Division - VFV B'){
          fixture['popularity'] = '127';
        } else if(fixture['league']['country'] == 'Belgium' && fixture['league']['name'] == 'Super League Women'){
          fixture['popularity'] = '128';
        } */else if(fixture['league']['country'] == 'Belize' && fixture['league']['name'] == 'Premier League'){
          fixture['popularity'] = '129';
        } else if(fixture['league']['country'] == 'Benin' && fixture['league']['name'] == 'Championnat National'){
          fixture['popularity'] = '130';
        } else if(fixture['league']['country'] == 'Bermuda' && fixture['league']['name'] == 'Premier League'){
          fixture['popularity'] = '131';
        } else if(fixture['league']['country'] == 'Bhutan' && fixture['league']['name'] == 'Super League'){
          fixture['popularity'] = '132';
        } else if(fixture['league']['country'] == 'Bolivia' && fixture['league']['name'] == 'Primera División'){
          fixture['popularity'] = '133';
        } else if(fixture['league']['country'] == 'Bosnia' && fixture['league']['name'] == 'Cup'){
          fixture['popularity'] = '134';
        } else if(fixture['league']['country'] == 'Bosnia' && fixture['league']['name'] == 'Premijer Liga'){
          fixture['popularity'] = '135';
        } else if(fixture['league']['country'] == 'Bosnia' && fixture['league']['name'] == '1st League - FBiH'){
          fixture['popularity'] = '136';
        } else if(fixture['league']['country'] == 'Bosnia' && fixture['league']['name'] == '1st League - RS'){
          fixture['popularity'] = '137';
        } else if(fixture['league']['country'] == 'Botswana' && fixture['league']['name'] == 'Premier League'){
          fixture['popularity'] = '138';
        } else if(fixture['league']['country'] == 'Brazil' && fixture['league']['name'] == 'Copa Do Brasil'){
          fixture['popularity'] = '139';
        } else if(fixture['league']['country'] == 'Brazil' && fixture['league']['name'] == 'Serie B'){
          fixture['popularity'] = '140';
        } else if(fixture['league']['country'] == 'Brazil' && fixture['league']['name'] == 'Serie C'){
          fixture['popularity'] = '141';
        } else if(fixture['league']['country'] == 'Brazil' && fixture['league']['name'] == 'Serie D'){
          fixture['popularity'] = '142';
        } /*else if(fixture['league']['country'] == 'Brazil' && fixture['league']['name'] == 'Amazonense'){
          fixture['popularity'] = '143';
        } else if(fixture['league']['country'] == 'Brazil' && fixture['league']['name'] == 'Amapaense'){
          fixture['popularity'] = '144';
        } else if(fixture['league']['country'] == 'Brazil' && fixture['league']['name'] == 'Baiano - 2'){
          fixture['popularity'] = '145';
        } else if(fixture['league']['country'] == 'Brazil' && fixture['league']['name'] == 'Cearense - 2'){
          fixture['popularity'] = '146';
        } else if(fixture['league']['country'] == 'Brazil' && fixture['league']['name'] == 'Acreano'){
          fixture['popularity'] = '147';
        } else if(fixture['league']['country'] == 'Brazil' && fixture['league']['name'] == 'Carioca - 2'){
          fixture['popularity'] = '148';
        } else if(fixture['league']['country'] == 'Brazil' && fixture['league']['name'] == 'Alagoano'){
          fixture['popularity'] = '149';
        } else if(fixture['league']['country'] == 'Brazil' && fixture['league']['name'] == 'Brasileiro Women'){
          fixture['popularity'] = '150';
        } */ else if(fixture['league']['country'] == 'Bulgaria' && fixture['league']['name'] == 'Cup'){
          fixture['popularity'] = '151';
        } /*else if(fixture['league']['country'] == 'Bulgaria' && fixture['league']['name'] == 'A PFG'){
          fixture['popularity'] = '152';
        } else if(fixture['league']['country'] == 'Bulgaria' && fixture['league']['name'] == 'B PFG'){
          fixture['popularity'] = '153';
        } else if(fixture['league']['country'] == 'Bulgaria' && fixture['league']['name'] == 'Third League - Southeast'){
          fixture['popularity'] = '154';
        } else if(fixture['league']['country'] == 'Bulgaria' && fixture['league']['name'] == 'Third League - Northeast'){
          fixture['popularity'] = '155';
        } else if(fixture['league']['country'] == 'Bulgaria' && fixture['league']['name'] == 'Third League - Northwest'){
          fixture['popularity'] = '156';
        } else if(fixture['league']['country'] == 'Bulgaria' && fixture['league']['name'] == 'Third League - Southwest'){
          fixture['popularity'] = '157';
        } */ else if(fixture['league']['country'] == 'Burkina-Faso' && fixture['league']['name'] == '1ere Division'){
          fixture['popularity'] = '158';
        } else if(fixture['league']['country'] == 'Burundi' && fixture['league']['name'] == 'Ligue A'){
          fixture['popularity'] = '159';
        } else if(fixture['league']['country'] == 'Cambodia' && fixture['league']['name'] == 'C-League'){
          fixture['popularity'] = '160';
        } else if(fixture['league']['country'] == 'Cameroon' && fixture['league']['name'] == 'Elite ONE'){
          fixture['popularity'] = '161';
        } else if(fixture['league']['country'] == 'Canada' && fixture['league']['name'] == 'Canadian Championship'){
          fixture['popularity'] = '162';
        } else if(fixture['league']['country'] == 'Canada' && fixture['league']['name'] == 'Canadian Soccer League'){
          fixture['popularity'] = '163';
        } else if(fixture['league']['country'] == 'Canada' && fixture['league']['name'] == 'Pacific Coast Soccer League'){
          fixture['popularity'] = '164';
        } else if(fixture['league']['country'] == 'Chile' && fixture['league']['name'] == 'Super Cup'){
          fixture['popularity'] = '165';
        } else if(fixture['league']['country'] == 'Chile' && fixture['league']['name'] == 'Primera Division'){
          fixture['popularity'] = '166';
        } else if(fixture['league']['country'] == 'Chile' && fixture['league']['name'] == 'Copa Chile'){
          fixture['popularity'] = '167';
        } /*else if(fixture['league']['country'] == 'Chile' && fixture['league']['name'] == 'Primera B'){
          fixture['popularity'] = '168';
        } */else if(fixture['league']['country'] == 'China' && fixture['league']['name'] == 'League One'){
          fixture['popularity'] = '169';
        } else if(fixture['league']['country'] == 'China' && fixture['league']['name'] == 'Super League'){
          fixture['popularity'] = '170';
        } else if(fixture['league']['country'] == 'China' && fixture['league']['name'] == 'FA Cup'){
          fixture['popularity'] = '171';
        } else if(fixture['league']['country'] == 'Chinese-Taipei' && fixture['league']['name'] == 'Taiwan Football Premier League'){
          fixture['popularity'] = '172';
        } else if(fixture['league']['country'] == 'Colombia' && fixture['league']['name'] == 'Copa Colombia'){
          fixture['popularity'] = '173';
        } else if(fixture['league']['country'] == 'Colombia' && fixture['league']['name'] == 'Primera A'){
          fixture['popularity'] = '174';
        } /*else if(fixture['league']['country'] == 'Colombia' && fixture['league']['name'] == 'Primera B'){
          fixture['popularity'] = '175';
        } */else if(fixture['league']['country'] == 'Congo-DR' && fixture['league']['name'] == 'Ligue 1'){
          fixture['popularity'] = '176';
        } else if(fixture['league']['country'] == 'Costa-Rica' && fixture['league']['name'] == 'Primera Division'){
          fixture['popularity'] = '177';
        } /*else if(fixture['league']['country'] == 'Costa-Rica' && fixture['league']['name'] == 'Liga De Ascenso'){
          fixture['popularity'] = '178';
        } */else if(fixture['league']['country'] == 'Croatia' && fixture['league']['name'] == 'Cup'){
          fixture['popularity'] = '179';
        } else if(fixture['league']['country'] == 'Croatia' && fixture['league']['name'] == 'Prva HNL'){
          fixture['popularity'] = '180';
        } /*else if(fixture['league']['country'] == 'Croatia' && fixture['league']['name'] == '3. HNL - Zapad'){
          fixture['popularity'] = '181';
        } else if(fixture['league']['country'] == 'Croatia' && fixture['league']['name'] == '3. HNL - Sjever'){
          fixture['popularity'] = '182';
        } else if(fixture['league']['country'] == 'Croatia' && fixture['league']['name'] == '3. HNL - Jug'){
          fixture['popularity'] = '183';
        } else if(fixture['league']['country'] == 'Croatia' && fixture['league']['name'] == '3. HNL - Istok'){
          fixture['popularity'] = '184';
        } else if(fixture['league']['country'] == 'Croatia' && fixture['league']['name'] == '3. HNL - Sredite'){
          fixture['popularity'] = '185';
        } */else if(fixture['league']['country'] == 'Croatia' && fixture['league']['name'] == 'Druga HNL'){
          fixture['popularity'] = '186';
        } else if(fixture['league']['country'] == 'Curacao' && fixture['league']['name'] == 'Curaçao Sekshon Pagá'){
          fixture['popularity'] = '187';
        } else if(fixture['league']['country'] == 'Cyprus' && fixture['league']['name'] == 'Cup'){
          fixture['popularity'] = '188';
        } else if(fixture['league']['country'] == 'Cyprus' && fixture['league']['name'] == '1. Division'){
          fixture['popularity'] = '189';
        } /*else if(fixture['league']['country'] == 'Cyprus' && fixture['league']['name'] == '2. Division'){
          fixture['popularity'] = '190';
        } else if(fixture['league']['country'] == 'Cyprus' && fixture['league']['name'] == '3. Division'){
          fixture['popularity'] = '191';
        }*/ else if(fixture['league']['country'] == 'Czech-Republic' && fixture['league']['name'] == 'Cup'){
          fixture['popularity'] = '192';
        } else if(fixture['league']['country'] == 'Czech-Republic' && fixture['league']['name'] == 'Czech Liga'){
          fixture['popularity'] = '193';
        } else if(fixture['league']['country'] == 'Czech-Republic' && fixture['league']['name'] == 'FNL'){
          fixture['popularity'] = '194';
        } /*else if(fixture['league']['country'] == 'Czech-Republic' && fixture['league']['name'] == '3. liga - MSFL'){
          fixture['popularity'] = '195';
        } else if(fixture['league']['country'] == 'Czech-Republic' && fixture['league']['name'] == '3. liga - CFL A'){
          fixture['popularity'] = '196';
        } else if(fixture['league']['country'] == 'Czech-Republic' && fixture['league']['name'] == '4. liga - Divizie A'){
          fixture['popularity'] = '197';
        } else if(fixture['league']['country'] == 'Czech-Republic' && fixture['league']['name'] == '4. liga - Divizie B'){
          fixture['popularity'] = '198';
        } else if(fixture['league']['country'] == 'Czech-Republic' && fixture['league']['name'] == '4. liga - Divizie C'){
          fixture['popularity'] = '199';
        } else if(fixture['league']['country'] == 'Czech-Republic' && fixture['league']['name'] == '4. liga - Divizie D'){
          fixture['popularity'] = '200';
        } else if(fixture['league']['country'] == 'Czech-Republic' && fixture['league']['name'] == '4. liga - Divizie E'){
          fixture['popularity'] = '201';
        }*/ else if(fixture['league']['country'] == 'Denmark' && fixture['league']['name'] == 'Superligaen'){
          fixture['popularity'] = '202';
        } else if(fixture['league']['country'] == 'Denmark' && fixture['league']['name'] == 'Elitedivisionen'){
          fixture['popularity'] = '203';
        } else if(fixture['league']['country'] == 'Denmark' && fixture['league']['name'] == 'DBU Pokalen'){
          fixture['popularity'] = '204';
        } /*else if(fixture['league']['country'] == 'Denmark' && fixture['league']['name'] == 'Viasat Divisionen'){
          fixture['popularity'] = '205';
        } else if(fixture['league']['country'] == 'Denmark' && fixture['league']['name'] == 'Denmark Series - Group 1'){
          fixture['popularity'] = '206';
        } else if(fixture['league']['country'] == 'Denmark' && fixture['league']['name'] == 'Denmark Series - Group 2'){
          fixture['popularity'] = '207';
        } else if(fixture['league']['country'] == 'Denmark' && fixture['league']['name'] == 'Denmark Series - Group 3'){
          fixture['popularity'] = '208';
        } else if(fixture['league']['country'] == 'Denmark' && fixture['league']['name'] == 'Denmark Series - Group 4'){
          fixture['popularity'] = '209';
        } else if(fixture['league']['country'] == 'Denmark' && fixture['league']['name'] == '2nd Division - Group 1'){
          fixture['popularity'] = '210';
        } else if(fixture['league']['country'] == 'Denmark' && fixture['league']['name'] == '2nd Division - Group 2'){
          fixture['popularity'] = '211';
        }*/ else if(fixture['league']['country'] == 'Ecuador' && fixture['league']['name'] == 'Serie A'){
          fixture['popularity'] = '212';
        } /*else if(fixture['league']['country'] == 'Ecuador' && fixture['league']['name'] == 'Serie B'){
          fixture['popularity'] = '213';
        }*/ else if(fixture['league']['country'] == 'Egypt' && fixture['league']['name'] == 'Premier League'){
          fixture['popularity'] = '214';
        } else if(fixture['league']['country'] == 'Egypt' && fixture['league']['name'] == 'Super Cup'){
          fixture['popularity'] = '215';
        } else if(fixture['league']['country'] == 'El-Salvador' && fixture['league']['name'] == 'Primera Division'){
          fixture['popularity'] = '216';
        } else if(fixture['league']['country'] == 'England' && fixture['league']['name'] == 'FA WSL'){
          fixture['popularity'] = '217';
        } else if(fixture['league']['country'] == 'England' && fixture['league']['name'] == 'National League'){
          fixture['popularity'] = '218';
        } /*else if(fixture['league']['country'] == 'England' && fixture['league']['name'] == 'Non League Div One - Isthmian North'){
          fixture['popularity'] = '219';
        } else if(fixture['league']['country'] == 'England' && fixture['league']['name'] == 'National League - North'){
          fixture['popularity'] = '220';
        } else if(fixture['league']['country'] == 'England' && fixture['league']['name'] == 'National League - South'){
          fixture['popularity'] = '221';
        } else if(fixture['league']['country'] == 'England' && fixture['league']['name'] == 'Non League Div One - Isthmian South'){
          fixture['popularity'] = '222';
        } else if(fixture['league']['country'] == 'England' && fixture['league']['name'] == 'Non League Div One - Northern North'){
          fixture['popularity'] = '223';
        } else if(fixture['league']['country'] == 'England' && fixture['league']['name'] == 'Non League Div One - Northern South'){
          fixture['popularity'] = '224';
        } else if(fixture['league']['country'] == 'England' && fixture['league']['name'] == 'Non League Div One - Southern Central'){
          fixture['popularity'] = '225';
        } else if(fixture['league']['country'] == 'England' && fixture['league']['name'] == 'Non League Div One - Southern SW'){
          fixture['popularity'] = '226';
        } else if(fixture['league']['country'] == 'England' && fixture['league']['name'] == 'Non League Premier - Isthmian'){
          fixture['popularity'] = '227';
        } else if(fixture['league']['country'] == 'England' && fixture['league']['name'] == 'Non League Premier - Northern'){
          fixture['popularity'] = '228';
        } else if(fixture['league']['country'] == 'England' && fixture['league']['name'] == 'Non League Premier - Southern'){
          fixture['popularity'] = '229';
        } */ else if(fixture['league']['country'] == 'England' && fixture['league']['name'] == 'FA Trophy'){
          fixture['popularity'] = '230';
        } else if(fixture['league']['country'] == 'England' && fixture['league']['name'] == 'EFL Trophy'){
          fixture['popularity'] = '231';
        } else if(fixture['league']['country'] == 'England' && fixture['league']['name'] == 'League One'){
          fixture['popularity'] = '232';
        } else if(fixture['league']['country'] == 'England' && fixture['league']['name'] == 'League Two'){
          fixture['popularity'] = '233';
        } else if(fixture['league']['country'] == 'Estonia' && fixture['league']['name'] == 'Esiliiga A'){
          fixture['popularity'] = '234';
        } else if(fixture['league']['country'] == 'Estonia' && fixture['league']['name'] == 'Meistriliiga'){
          fixture['popularity'] = '235';
        } else if(fixture['league']['country'] == 'Ethiopia' && fixture['league']['name'] == 'Premier League'){
          fixture['popularity'] = '236';
        } else if(fixture['league']['country'] == 'Faroe-Islands' && fixture['league']['name'] == '1. Deild'){
          fixture['popularity'] = '237';
        } /*else if(fixture['league']['country'] == 'Faroe-Islands' && fixture['league']['name'] == 'Løgmanssteypid'){
          fixture['popularity'] = '238';
        } else if(fixture['league']['country'] == 'Faroe-Islands' && fixture['league']['name'] == 'Meistaradeildin'){
          fixture['popularity'] = '239';
        }*/ else if(fixture['league']['country'] == 'Fiji' && fixture['league']['name'] == 'National Football League'){
          fixture['popularity'] = '240';
        } else if(fixture['league']['country'] == 'Finland' && fixture['league']['name'] == 'Ykkonen'){
          fixture['popularity'] = '241';
        } else if(fixture['league']['country'] == 'Finland' && fixture['league']['name'] == 'Suomen Cup'){
          fixture['popularity'] = '242';
        } else if(fixture['league']['country'] == 'Finland' && fixture['league']['name'] == 'Veikkausliiga'){
          fixture['popularity'] = '243';
        } else if(fixture['league']['country'] == 'Finland' && fixture['league']['name'] == 'Kakkonen - Lohko A'){
          fixture['popularity'] = '244';
        } /*else if(fixture['league']['country'] == 'Finland' && fixture['league']['name'] == 'Kakkonen - Lohko B'){
          fixture['popularity'] = '245';
        } else if(fixture['league']['country'] == 'Finland' && fixture['league']['name'] == 'Kakkonen - Lohko C'){
          fixture['popularity'] = '246';
        } */else if(fixture['league']['country'] == 'France' && fixture['league']['name'] == 'Ligue 2'){
          fixture['popularity'] = '247';
        } else if(fixture['league']['country'] == 'France' && fixture['league']['name'] == 'National'){
          fixture['popularity'] = '248';
        } /*else if(fixture['league']['country'] == 'France' && fixture['league']['name'] == 'National 2 - Group A'){
          fixture['popularity'] = '249';
        } else if(fixture['league']['country'] == 'France' && fixture['league']['name'] == 'National 2 - Group B'){
          fixture['popularity'] = '250';
        } else if(fixture['league']['country'] == 'France' && fixture['league']['name'] == 'National 2 - Group C'){
          fixture['popularity'] = '251';
        } else if(fixture['league']['country'] == 'France' && fixture['league']['name'] == 'National 2 - Group D'){
          fixture['popularity'] = '252';
        } else if(fixture['league']['country'] == 'France' && fixture['league']['name'] == 'National 3 - Group A'){
          fixture['popularity'] = '253';
        } else if(fixture['league']['country'] == 'France' && fixture['league']['name'] == 'National 3 - Group B'){
          fixture['popularity'] = '254';
        } else if(fixture['league']['country'] == 'France' && fixture['league']['name'] == 'National 3 - Group C'){
          fixture['popularity'] = '255';
        } else if(fixture['league']['country'] == 'France' && fixture['league']['name'] == 'National 3 - Group D'){
          fixture['popularity'] = '256';
        } else if(fixture['league']['country'] == 'France' && fixture['league']['name'] == 'National 3 - Group E'){
          fixture['popularity'] = '257';
        } else if(fixture['league']['country'] == 'France' && fixture['league']['name'] == 'National 3 - Group F'){
          fixture['popularity'] = '258';
        } else if(fixture['league']['country'] == 'France' && fixture['league']['name'] == 'National 3 - Group H'){
          fixture['popularity'] = '259';
        } else if(fixture['league']['country'] == 'France' && fixture['league']['name'] == 'National 3 - Group I'){
          fixture['popularity'] = '260';
        } else if(fixture['league']['country'] == 'France' && fixture['league']['name'] == 'National 3 - Group J'){
          fixture['popularity'] = '261';
        } else if(fixture['league']['country'] == 'France' && fixture['league']['name'] == 'National 3 - Group K'){
          fixture['popularity'] = '262';
        } else if(fixture['league']['country'] == 'France' && fixture['league']['name'] == 'National 3 - Group L'){
          fixture['popularity'] = '263';
        } else if(fixture['league']['country'] == 'France' && fixture['league']['name'] == 'National 3 - Group M'){
          fixture['popularity'] = '264';
        } else if(fixture['league']['country'] == 'France' && fixture['league']['name'] == 'Feminine Division 1'){
          fixture['popularity'] = '265';
        } */else if(fixture['league']['country'] == 'Georgia' && fixture['league']['name'] == 'Super Cup'){
          fixture['popularity'] = '266';
        } else if(fixture['league']['country'] == 'Georgia' && fixture['league']['name'] == 'Erovnuli Liga'){
          fixture['popularity'] = '267';
        } /*else if(fixture['league']['country'] == 'Georgia' && fixture['league']['name'] == 'Erovnuli Liga 2'){
          fixture['popularity'] = '268';
        } */else if(fixture['league']['country'] == 'Germany' && fixture['league']['name'] == 'Super Cup'){
          fixture['popularity'] = '269';
        } else if(fixture['league']['country'] == 'Germany' && fixture['league']['name'] == 'Bundesliga 2'){
          fixture['popularity'] = '270';
        } else if(fixture['league']['country'] == 'Germany' && fixture['league']['name'] == 'Liga 3'){
          fixture['popularity'] = '271';
        } /*else if(fixture['league']['country'] == 'Germany' && fixture['league']['name'] == 'Regionalliga - Nordost'){
          fixture['popularity'] = '272';
        } else if(fixture['league']['country'] == 'Germany' && fixture['league']['name'] == 'Regionalliga - Bayern'){
          fixture['popularity'] = '273';
        } else if(fixture['league']['country'] == 'Germany' && fixture['league']['name'] == 'Regionalliga - Nord'){
          fixture['popularity'] = '274';
        } else if(fixture['league']['country'] == 'Germany' && fixture['league']['name'] == 'Regionalliga - West'){
          fixture['popularity'] = '275';
        } else if(fixture['league']['country'] == 'Germany' && fixture['league']['name'] == 'Regionalliga - SudWest'){
          fixture['popularity'] = '276';
        } else if(fixture['league']['country'] == 'Germany' && fixture['league']['name'] == 'U19 Bundesliga'){
          fixture['popularity'] = '277';
        } else if(fixture['league']['country'] == 'Germany' && fixture['league']['name'] == 'Women Bundesliga'){
          fixture['popularity'] = '278';
        } */else if(fixture['league']['country'] == 'Ghana' && fixture['league']['name'] == 'Premier League'){
          fixture['popularity'] = '279';
        } else if(fixture['league']['country'] == 'Greece' && fixture['league']['name'] == 'Cup'){
          fixture['popularity'] = '280';
        } else if(fixture['league']['country'] == 'Greece' && fixture['league']['name'] == 'Super League'){
          fixture['popularity'] = '281';
        } /*else if(fixture['league']['country'] == 'Greece' && fixture['league']['name'] == 'Super League 2'){
          fixture['popularity'] = '282';
        } else if(fixture['league']['country'] == 'Greece' && fixture['league']['name'] == 'Football League'){
          fixture['popularity'] = '283';
        } else if(fixture['league']['country'] == 'Greece' && fixture['league']['name'] == 'Gamma Ethniki - Group 1'){
          fixture['popularity'] = '284';
        } else if(fixture['league']['country'] == 'Greece' && fixture['league']['name'] == 'Gamma Ethniki - Group 2'){
          fixture['popularity'] = '285';
        } else if(fixture['league']['country'] == 'Greece' && fixture['league']['name'] == 'Gamma Ethniki - Group 3'){
          fixture['popularity'] = '286';
        } else if(fixture['league']['country'] == 'Greece' && fixture['league']['name'] == 'Gamma Ethniki - Group 4'){
          fixture['popularity'] = '287';
        } else if(fixture['league']['country'] == 'Greece' && fixture['league']['name'] == 'Gamma Ethniki - Group 5'){
          fixture['popularity'] = '288';
        } else if(fixture['league']['country'] == 'Greece' && fixture['league']['name'] == 'Gamma Ethniki - Group 6'){
          fixture['popularity'] = '289';
        } else if(fixture['league']['country'] == 'Greece' && fixture['league']['name'] == 'Gamma Ethniki - Group 7'){
          fixture['popularity'] = '290';
        } else if(fixture['league']['country'] == 'Greece' && fixture['league']['name'] == 'Gamma Ethniki - Group 8'){
          fixture['popularity'] = '291';
        } */else if(fixture['league']['country'] == 'Guadeloupe' && fixture['league']['name'] == 'Division d\'Honneur'){
          fixture['popularity'] = '292';
        } else if(fixture['league']['country'] == 'Guatemala' && fixture['league']['name'] == 'Primera Division'){
          fixture['popularity'] = '293';
        } else if(fixture['league']['country'] == 'Guatemala' && fixture['league']['name'] == 'Liga Nacional'){
          fixture['popularity'] = '294';
        } else if(fixture['league']['country'] == 'Guinea' && fixture['league']['name'] == 'Ligue 1'){
          fixture['popularity'] = '295';
        } else if(fixture['league']['country'] == 'Haiti' && fixture['league']['name'] == 'Ligue Haïtienne'){
          fixture['popularity'] = '296';
        } else if(fixture['league']['country'] == 'Honduras' && fixture['league']['name'] == 'Liga Nacional de Fútbol'){
          fixture['popularity'] = '297';
        } else if(fixture['league']['country'] == 'Hong-Kong' && fixture['league']['name'] == 'Premier League'){
          fixture['popularity'] = '298';
        } else if(fixture['league']['country'] == 'Hong-Kong' && fixture['league']['name'] == 'HKFA 1st Division'){
          fixture['popularity'] = '299';
        } else if(fixture['league']['country'] == 'Hungary' && fixture['league']['name'] == 'Magyar Kupa'){
          fixture['popularity'] = '300';
        } else if(fixture['league']['country'] == 'Hungary' && fixture['league']['name'] == 'NB I'){
          fixture['popularity'] = '301';
        } /*else if(fixture['league']['country'] == 'Hungary' && fixture['league']['name'] == 'NB II'){
          fixture['popularity'] = '302';
        } else if(fixture['league']['country'] == 'Hungary' && fixture['league']['name'] == 'NB III - Közép'){
          fixture['popularity'] = '303';
        } else if(fixture['league']['country'] == 'Hungary' && fixture['league']['name'] == 'NB III - Keleti'){
          fixture['popularity'] = '304';
        } else if(fixture['league']['country'] == 'Hungary' && fixture['league']['name'] == 'NB III - Nyugati'){
          fixture['popularity'] = '305';
        } */else if(fixture['league']['country'] == 'Iceland' && fixture['league']['name'] == 'Cup'){
          fixture['popularity'] = '306';
        } else if(fixture['league']['country'] == 'Iceland' && fixture['league']['name'] == 'League Cup'){
          fixture['popularity'] = '307';
        } else if(fixture['league']['country'] == 'Iceland' && fixture['league']['name'] == 'Premier'){
          fixture['popularity'] = '308';
        } else if(fixture['league']['country'] == 'Iceland' && fixture['league']['name'] == 'Division 1'){
          fixture['popularity'] = '309';
        } /*else if(fixture['league']['country'] == 'Iceland' && fixture['league']['name'] == 'Division 2'){
          fixture['popularity'] = '310';
        } */else if(fixture['league']['country'] == 'India' && fixture['league']['name'] == 'Indian Super League'){
          fixture['popularity'] = '311';
        } else if(fixture['league']['country'] == 'India' && fixture['league']['name'] == 'I-League'){
          fixture['popularity'] = '312';
        } else if(fixture['league']['country'] == 'India' && fixture['league']['name'] == 'AIFF Super Cup'){
          fixture['popularity'] = '313';
        } else if(fixture['league']['country'] == 'India' && fixture['league']['name'] == 'Santosh Trophy'){
          fixture['popularity'] = '314';
        } else if(fixture['league']['country'] == 'Indonesia' && fixture['league']['name'] == 'Super League'){
          fixture['popularity'] = '315';
        } /*else if(fixture['league']['country'] == 'Indonesia' && fixture['league']['name'] == 'Liga 2'){
          fixture['popularity'] = '316';
        } */else if(fixture['league']['country'] == 'Iran' && fixture['league']['name'] == 'Persian Gulf Cup'){
          fixture['popularity'] = '317';
        } else if(fixture['league']['country'] == 'Iran' && fixture['league']['name'] == 'Hazfi Cup'){
          fixture['popularity'] = '318';
        } else if(fixture['league']['country'] == 'Iran' && fixture['league']['name'] == 'Azadegan League'){
          fixture['popularity'] = '319';
        } else if(fixture['league']['country'] == 'Ireland' && fixture['league']['name'] == 'FAI President\'s Cup'){
          fixture['popularity'] = '320';
        } else if(fixture['league']['country'] == 'Ireland' && fixture['league']['name'] == 'FAI Cup'){
          fixture['popularity'] = '321';
        } else if(fixture['league']['country'] == 'Ireland' && fixture['league']['name'] == 'League Cup'){
          fixture['popularity'] = '322';
        } else if(fixture['league']['country'] == 'Ireland' && fixture['league']['name'] == 'Premier Division'){
          fixture['popularity'] = '323';
        } else if(fixture['league']['country'] == 'Ireland' && fixture['league']['name'] == 'First Division'){
          fixture['popularity'] = '324';
        } /*else if(fixture['league']['country'] == 'Israel' && fixture['league']['name'] == 'State Cup'){
          fixture['popularity'] = '325';
        } else if(fixture['league']['country'] == 'Israel' && fixture['league']['name'] == 'Toto Cup Ligat Al'){
          fixture['popularity'] = '326';
        } else if(fixture['league']['country'] == 'Israel' && fixture['league']['name'] == 'Ligat ha\'Al'){
          fixture['popularity'] = '327';
        } else if(fixture['league']['country'] == 'Israel' && fixture['league']['name'] == 'Liga Leumit'){
          fixture['popularity'] = '328';
        } else if(fixture['league']['country'] == 'Israel' && fixture['league']['name'] == 'Liga Alef'){
          fixture['popularity'] = '329';
        } */else if(fixture['league']['country'] == 'Italy' && fixture['league']['name'] == 'Serie B'){
          fixture['popularity'] = '330';
        } else if(fixture['league']['country'] == 'Italy' && fixture['league']['name'] == 'Serie C'){
          fixture['popularity'] = '331';
        } /*else if(fixture['league']['country'] == 'Italy' && fixture['league']['name'] == 'Serie D - Girone A'){
          fixture['popularity'] = '332';
        } else if(fixture['league']['country'] == 'Italy' && fixture['league']['name'] == 'Serie D - Girone B'){
          fixture['popularity'] = '333';
        } else if(fixture['league']['country'] == 'Italy' && fixture['league']['name'] == 'Serie D - Girone C'){
          fixture['popularity'] = '334';
        } else if(fixture['league']['country'] == 'Italy' && fixture['league']['name'] == 'Serie D - Girone D'){
          fixture['popularity'] = '335';
        } else if(fixture['league']['country'] == 'Italy' && fixture['league']['name'] == 'Serie D - Girone E'){
          fixture['popularity'] = '336';
        } else if(fixture['league']['country'] == 'Italy' && fixture['league']['name'] == 'Serie D - Girone F'){
          fixture['popularity'] = '337';
        } else if(fixture['league']['country'] == 'Italy' && fixture['league']['name'] == 'Serie D - Girone G'){
          fixture['popularity'] = '338';
        } else if(fixture['league']['country'] == 'Italy' && fixture['league']['name'] == 'Serie D - Girone H'){
          fixture['popularity'] = '339';
        } else if(fixture['league']['country'] == 'Italy' && fixture['league']['name'] == 'Serie D - Girone I'){
          fixture['popularity'] = '340';
        } else if(fixture['league']['country'] == 'Italy' && fixture['league']['name'] == 'Serie A Women'){
          fixture['popularity'] = '341';
        } */else if(fixture['league']['country'] == 'Ivory-Coast' && fixture['league']['name'] == 'Ligue 1'){
          fixture['popularity'] = '342';
        } else if(fixture['league']['country'] == 'Jamaica' && fixture['league']['name'] == 'Premier League'){
          fixture['popularity'] = '343';
        } else if(fixture['league']['country'] == 'Japan' && fixture['league']['name'] == 'Emperor Cup'){
          fixture['popularity'] = '344';
        } else if(fixture['league']['country'] == 'Japan' && fixture['league']['name'] == 'Japan Football League'){
          fixture['popularity'] = '345';
        } else if(fixture['league']['country'] == 'Japan' && fixture['league']['name'] == 'J-League Cup'){
          fixture['popularity'] = '346';
        } else if(fixture['league']['country'] == 'Japan' && fixture['league']['name'] == 'J. League Div.1'){
          fixture['popularity'] = '347';
        } /*else if(fixture['league']['country'] == 'Japan' && fixture['league']['name'] == 'J. League Div.2'){
          fixture['popularity'] = '348';
        } else if(fixture['league']['country'] == 'Japan' && fixture['league']['name'] == 'J. League Div.3'){
          fixture['popularity'] = '349';
        } */else if(fixture['league']['country'] == 'Jordan' && fixture['league']['name'] == 'Division 1'){
          fixture['popularity'] = '350';
        } else if(fixture['league']['country'] == 'Kazakhstan' && fixture['league']['name'] == 'Cup'){
          fixture['popularity'] = '351';
        } else if(fixture['league']['country'] == 'Kazakhstan' && fixture['league']['name'] == 'Premier League'){
          fixture['popularity'] = '352';
        } else if(fixture['league']['country'] == 'Kazakhstan' && fixture['league']['name'] == '1. Division'){
          fixture['popularity'] = '353';
        } else if(fixture['league']['country'] == 'Kenya' && fixture['league']['name'] == 'Premier League'){
          fixture['popularity'] = '354';
        } else if(fixture['league']['country'] == 'Kosovo' && fixture['league']['name'] == 'Cup'){
          fixture['popularity'] = '355';
        } else if(fixture['league']['country'] == 'Kosovo' && fixture['league']['name'] == 'Superliga'){
          fixture['popularity'] = '356';
        } else if(fixture['league']['country'] == 'Kuwait' && fixture['league']['name'] == 'Premier League'){
          fixture['popularity'] = '357';
        } else if(fixture['league']['country'] == 'Kuwait' && fixture['league']['name'] == 'Division 1'){
          fixture['popularity'] = '358';
        } else if(fixture['league']['country'] == 'Kyrgyzstan' && fixture['league']['name'] == 'Premier League'){
          fixture['popularity'] = '359';
        } else if(fixture['league']['country'] == 'Latvia' && fixture['league']['name'] == '1. Liga'){
          fixture['popularity'] = '360';
        } else if(fixture['league']['country'] == 'Latvia' && fixture['league']['name'] == 'Virsliga'){
          fixture['popularity'] = '361';
        } else if(fixture['league']['country'] == 'Lebanon' && fixture['league']['name'] == 'Premier League'){
          fixture['popularity'] = '362';
        } else if(fixture['league']['country'] == 'Lithuania' && fixture['league']['name'] == 'A Lyga'){
          fixture['popularity'] = '363';
        } else if(fixture['league']['country'] == 'Lithuania' && fixture['league']['name'] == '1 Lyga'){
          fixture['popularity'] = '364';
        } else if(fixture['league']['country'] == 'Luxembourg' && fixture['league']['name'] == 'National Division'){
          fixture['popularity'] = '365';
        } else if(fixture['league']['country'] == 'Macedonia' && fixture['league']['name'] == 'First League'){
          fixture['popularity'] = '366';
        } /*else if(fixture['league']['country'] == 'Macedonia' && fixture['league']['name'] == 'Second League'){
          fixture['popularity'] = '367';
        } */else if(fixture['league']['country'] == 'Malawi' && fixture['league']['name'] == 'Super League'){
          fixture['popularity'] = '368';
        } else if(fixture['league']['country'] == 'Malaysia' && fixture['league']['name'] == 'Malaysia Cup'){
          fixture['popularity'] = '369';
        } else if(fixture['league']['country'] == 'Malaysia' && fixture['league']['name'] == 'Premier League'){
          fixture['popularity'] = '370';
        } else if(fixture['league']['country'] == 'Malaysia' && fixture['league']['name'] == 'Super League'){
          fixture['popularity'] = '371';
        } else if(fixture['league']['country'] == 'Mali' && fixture['league']['name'] == 'Première Division'){
          fixture['popularity'] = '372';
        } else if(fixture['league']['country'] == 'Malta' && fixture['league']['name'] == 'Premier League'){
          fixture['popularity'] = '373';
        } else if(fixture['league']['country'] == 'Malta' && fixture['league']['name'] == 'First Division'){
          fixture['popularity'] = '374';
        } else if(fixture['league']['country'] == 'Mexico' && fixture['league']['name'] == 'Copa MX'){
          fixture['popularity'] = '375';
        } else if(fixture['league']['country'] == 'Mexico' && fixture['league']['name'] == 'Liga MX'){
          fixture['popularity'] = '376';
        } else if(fixture['league']['country'] == 'Mexico' && fixture['league']['name'] == 'Ascenso MX'){
          fixture['popularity'] = '377';
        } else if(fixture['league']['country'] == 'Moldova' && fixture['league']['name'] == 'Divizia Națională'){
          fixture['popularity'] = '378';
        } else if(fixture['league']['country'] == 'Moldova' && fixture['league']['name'] == 'Divizia A'){
          fixture['popularity'] = '379';
        } else if(fixture['league']['country'] == 'Montenegro' && fixture['league']['name'] == 'First League'){
          fixture['popularity'] = '380';
        } else if(fixture['league']['country'] == 'Montenegro' && fixture['league']['name'] == 'Second League'){
          fixture['popularity'] = '381';
        } else if(fixture['league']['country'] == 'Morocco' && fixture['league']['name'] == 'Botola Pro'){
          fixture['popularity'] = '382';
        } /*else if(fixture['league']['country'] == 'Morocco' && fixture['league']['name'] == 'Botola 2'){
          fixture['popularity'] = '383';
        } */else if(fixture['league']['country'] == 'Myanmar' && fixture['league']['name'] == 'National League'){
          fixture['popularity'] = '384';
        } else if(fixture['league']['country'] == 'Nepal' && fixture['league']['name'] == 'A Division'){
          fixture['popularity'] = '385';
        } else if(fixture['league']['country'] == 'Netherlands' && fixture['league']['name'] == 'Super Cup'){
          fixture['popularity'] = '386';
        } else if(fixture['league']['country'] == 'Netherlands' && fixture['league']['name'] == 'Eerste Divisie'){
          fixture['popularity'] = '387';
        } /*else if(fixture['league']['country'] == 'Netherlands' && fixture['league']['name'] == 'Tweede Divisie'){
          fixture['popularity'] = '388';
        } else if(fixture['league']['country'] == 'Netherlands' && fixture['league']['name'] == 'Derde Divisie - Saturday'){
          fixture['popularity'] = '389';
        } else if(fixture['league']['country'] == 'Netherlands' && fixture['league']['name'] == 'Derde Divisie - Sunday'){
          fixture['popularity'] = '390';
        } else if(fixture['league']['country'] == 'Netherlands' && fixture['league']['name'] == 'KNVB Beker'){
          fixture['popularity'] = '391';
        } else if(fixture['league']['country'] == 'Netherlands' && fixture['league']['name'] == 'Eredivisie Women'){
          fixture['popularity'] = '392';
        } */else if(fixture['league']['country'] == 'New-Zealand' && fixture['league']['name'] == 'Football Championship'){
          fixture['popularity'] = '393';
        } else if(fixture['league']['country'] == 'Nicaragua' && fixture['league']['name'] == 'Primera Division'){
          fixture['popularity'] = '394';
        } else if(fixture['league']['country'] == 'Nigeria' && fixture['league']['name'] == 'NPFL'){
          fixture['popularity'] = '395';
        } else if(fixture['league']['country'] == 'Northern-Ireland' && fixture['league']['name'] == 'Championship'){
          fixture['popularity'] = '396';
        } else if(fixture['league']['country'] == 'Northern-Ireland' && fixture['league']['name'] == 'League Cup'){
          fixture['popularity'] = '397';
        } else if(fixture['league']['country'] == 'Northern-Ireland' && fixture['league']['name'] == 'Premiership'){
          fixture['popularity'] = '398';
        } /*else if(fixture['league']['country'] == 'Northern-Ireland' && fixture['league']['name'] == 'Premier Intermediate League'){
          fixture['popularity'] = '399';
        } */ else if(fixture['league']['country'] == 'Norway' && fixture['league']['name'] == 'Eliteserien'){
          fixture['popularity'] = '400';
        } else if(fixture['league']['country'] == 'Norway' && fixture['league']['name'] == 'Super Cup'){
          fixture['popularity'] = '401';
        } /*else if(fixture['league']['country'] == 'Norway' && fixture['league']['name'] == 'NM Cupen'){
          fixture['popularity'] = '402';
        } else if(fixture['league']['country'] == 'Norway' && fixture['league']['name'] == 'OBOS-ligaen'){
          fixture['popularity'] = '403';
        } else if(fixture['league']['country'] == 'Norway' && fixture['league']['name'] == '2. Division - Group 1'){
          fixture['popularity'] = '404';
        } else if(fixture['league']['country'] == 'Norway' && fixture['league']['name'] == '2. Division - Group 2'){
          fixture['popularity'] = '405';
        } */else if(fixture['league']['country'] == 'Oman' && fixture['league']['name'] == 'Professional League'){
          fixture['popularity'] = '406';
        } else if(fixture['league']['country'] == 'Palestine' && fixture['league']['name'] == 'West Bank Premier League'){
          fixture['popularity'] = '407';
        } else if(fixture['league']['country'] == 'Panama' && fixture['league']['name'] == 'Liga Panameña de Fútbol'){
          fixture['popularity'] = '408';
        } else if(fixture['league']['country'] == 'Paraguay' && fixture['league']['name'] == 'Copa Paraguay'){
          fixture['popularity'] = '409';
        } else if(fixture['league']['country'] == 'Paraguay' && fixture['league']['name'] == 'Primera Division - Apertura'){
          fixture['popularity'] = '410';
        } else if(fixture['league']['country'] == 'Paraguay' && fixture['league']['name'] == 'Primera Division - Clausura'){
          fixture['popularity'] = '411';
        } /*else if(fixture['league']['country'] == 'Paraguay' && fixture['league']['name'] == 'Segunda Division'){
          fixture['popularity'] = '412';
        } */else if(fixture['league']['country'] == 'Peru' && fixture['league']['name'] == 'Copa Perú'){
          fixture['popularity'] = '413';
        } else if(fixture['league']['country'] == 'Peru' && fixture['league']['name'] == 'Primera Division'){
          fixture['popularity'] = '414';
        } else if(fixture['league']['country'] == 'Peru' && fixture['league']['name'] == 'Copa Bicentenario'){
          fixture['popularity'] = '415';
        } /*else if(fixture['league']['country'] == 'Peru' && fixture['league']['name'] == 'Segunda Division'){
          fixture['popularity'] = '416';
        } */else if(fixture['league']['country'] == 'Poland' && fixture['league']['name'] == 'Cup'){
          fixture['popularity'] = '417';
        } else if(fixture['league']['country'] == 'Poland' && fixture['league']['name'] == 'I Liga'){
          fixture['popularity'] = '418';
        } /*else if(fixture['league']['country'] == 'Poland' && fixture['league']['name'] == 'II Liga'){
          fixture['popularity'] = '419';
        } else if(fixture['league']['country'] == 'Poland' && fixture['league']['name'] == 'Ekstraklasa'){
          fixture['popularity'] = '420';
        } */else if(fixture['league']['country'] == 'Portugal' && fixture['league']['name'] == 'Super Cup'){
          fixture['popularity'] = '421';
        } else if(fixture['league']['country'] == 'Portugal' && fixture['league']['name'] == 'Liga de Honra'){
          fixture['popularity'] = '422';
        } else if(fixture['league']['country'] == 'Portugal' && fixture['league']['name'] == 'Taça de Portugal'){
          fixture['popularity'] = '423';
        } else if(fixture['league']['country'] == 'Portugal' && fixture['league']['name'] == 'Taça de Liga'){
          fixture['popularity'] = '424';
        } /*else if(fixture['league']['country'] == 'Portugal' && fixture['league']['name'] == 'Campeonato de Portugal Prio - Group A'){
          fixture['popularity'] = '425';
        } else if(fixture['league']['country'] == 'Portugal' && fixture['league']['name'] == 'Campeonato de Portugal Prio - Group B'){
          fixture['popularity'] = '426';
        } else if(fixture['league']['country'] == 'Portugal' && fixture['league']['name'] == 'Campeonato de Portugal Prio - Group C'){
          fixture['popularity'] = '427';
        } else if(fixture['league']['country'] == 'Portugal' && fixture['league']['name'] == 'Campeonato de Portugal Prio - Group D'){
          fixture['popularity'] = '428';
        } */ else if(fixture['league']['country'] == 'Qatar' && fixture['league']['name'] == 'QSL Cup'){
          fixture['popularity'] = '429';
        } else if(fixture['league']['country'] == 'Qatar' && fixture['league']['name'] == 'Stars League'){
          fixture['popularity'] = '430';
        } /*else if(fixture['league']['country'] == 'Qatar' && fixture['league']['name'] == '2nd Division League'){
          fixture['popularity'] = '431';
        } */else if(fixture['league']['country'] == 'Romania' && fixture['league']['name'] == 'Supercupa'){
          fixture['popularity'] = '432';
        } else if(fixture['league']['country'] == 'Romania' && fixture['league']['name'] == 'Cupa României'){
          fixture['popularity'] = '433';
        } else if(fixture['league']['country'] == 'Romania' && fixture['league']['name'] == 'Liga I'){
          fixture['popularity'] = '434';
        } /*else if(fixture['league']['country'] == 'Romania' && fixture['league']['name'] == 'Liga II'){
          fixture['popularity'] = '435';
        }*/ else if(fixture['league']['country'] == 'Russia' && fixture['league']['name'] == 'Cup'){
          fixture['popularity'] = '436';
        } else if(fixture['league']['country'] == 'Russia' && fixture['league']['name'] == 'Premier League'){
          fixture['popularity'] = '437';
        } else if(fixture['league']['country'] == 'Russia' && fixture['league']['name'] == 'Football National League'){
          fixture['popularity'] = '438';
        } /*else if(fixture['league']['country'] == 'Russia' && fixture['league']['name'] == 'Youth Championship'){
          fixture['popularity'] = '439';
        } */else if(fixture['league']['country'] == 'Rwanda' && fixture['league']['name'] == 'National Soccer League'){
          fixture['popularity'] = '440';
        } else if(fixture['league']['country'] == 'San-Marino' && fixture['league']['name'] == 'Campionato'){
          fixture['popularity'] = '441';
        } else if(fixture['league']['country'] == 'Saudi-Arabia' && fixture['league']['name'] == 'King\'s Cup'){
          fixture['popularity'] = '442';
        } else if(fixture['league']['country'] == 'Saudi-Arabia' && fixture['league']['name'] == 'Pro League'){
          fixture['popularity'] = '443';
        } else if(fixture['league']['country'] == 'Saudi-Arabia' && fixture['league']['name'] == 'Division 1'){
          fixture['popularity'] = '444';
        } else if(fixture['league']['country'] == 'Scotland' && fixture['league']['name'] == 'FA Cup'){
          fixture['popularity'] = '445';
        } else if(fixture['league']['country'] == 'Scotland' && fixture['league']['name'] == 'League Cup'){
          fixture['popularity'] = '446';
        } else if(fixture['league']['country'] == 'Scotland' && fixture['league']['name'] == 'Challenge Cup'){
          fixture['popularity'] = '447';
        } else if(fixture['league']['country'] == 'Scotland' && fixture['league']['name'] == 'Championship'){
          fixture['popularity'] = '448';
        } else if(fixture['league']['country'] == 'Scotland' && fixture['league']['name'] == 'Premiership'){
          fixture['popularity'] = '449';
        } else if(fixture['league']['country'] == 'Scotland' && fixture['league']['name'] == 'League One'){
          fixture['popularity'] = '450';
        } /*else if(fixture['league']['country'] == 'Scotland' && fixture['league']['name'] == 'League Two'){
          fixture['popularity'] = '451';
        } */else if(fixture['league']['country'] == 'Senegal' && fixture['league']['name'] == 'Ligue 1'){
          fixture['popularity'] = '452';
        } else if(fixture['league']['country'] == 'Serbia' && fixture['league']['name'] == 'Super Liga'){
          fixture['popularity'] = '453';
        } else if(fixture['league']['country'] == 'Serbia' && fixture['league']['name'] == 'Prva Liga'){
          fixture['popularity'] = '454';
        } /*else if(fixture['league']['country'] == 'Serbia' && fixture['league']['name'] == 'Srpska Liga - Vojvodina'){
          fixture['popularity'] = '455';
        } else if(fixture['league']['country'] == 'Serbia' && fixture['league']['name'] == 'Srpska Liga - East'){
          fixture['popularity'] = '456';
        } else if(fixture['league']['country'] == 'Serbia' && fixture['league']['name'] == 'Srpska Liga - West'){
          fixture['popularity'] = '457';
        } else if(fixture['league']['country'] == 'Serbia' && fixture['league']['name'] == 'Srpska Liga - Belgrade'){
          fixture['popularity'] = '458';
        } */else if(fixture['league']['country'] == 'Singapore' && fixture['league']['name'] == 'Premier League'){
          fixture['popularity'] = '459';
        } else if(fixture['league']['country'] == 'Slovakia' && fixture['league']['name'] == 'Super Liga'){
          fixture['popularity'] = '460';
        } /*else if(fixture['league']['country'] == 'Slovakia' && fixture['league']['name'] == '2. liga'){
          fixture['popularity'] = '461';
        } */ else if(fixture['league']['country'] == 'Slovenia' && fixture['league']['name'] == 'Cup'){
          fixture['popularity'] = '462';
        } else if(fixture['league']['country'] == 'Slovenia' && fixture['league']['name'] == '1. SNL'){
          fixture['popularity'] = '463';
        } /* else if(fixture['league']['country'] == 'Slovenia' && fixture['league']['name'] == '2. SNL'){
          fixture['popularity'] = '464';
        } */else if(fixture['league']['country'] == 'South-Africa' && fixture['league']['name'] == 'Cup'){
          fixture['popularity'] = '465';
        } else if(fixture['league']['country'] == 'South-Africa' && fixture['league']['name'] == 'Premier Soccer League'){
          fixture['popularity'] = '466';
        } else if(fixture['league']['country'] == 'South-Africa' && fixture['league']['name'] == '1st Division'){
          fixture['popularity'] = '467';
        } else if(fixture['league']['country'] == 'South-Africa' && fixture['league']['name'] == 'League Cup'){
          fixture['popularity'] = '468';
        } /*else if(fixture['league']['country'] == 'South-Africa' && fixture['league']['name'] == '8 Cup'){
          fixture['popularity'] = '469';
        } */else if(fixture['league']['country'] == 'South-Korea' && fixture['league']['name'] == 'FA Cup'){
          fixture['popularity'] = '470';
        } else if(fixture['league']['country'] == 'South-Korea' && fixture['league']['name'] == 'National League'){
          fixture['popularity'] = '471';
        } /*else if(fixture['league']['country'] == 'South-Korea' && fixture['league']['name'] == 'K-League Challenge'){
          fixture['popularity'] = '472';
        } else if(fixture['league']['country'] == 'South-Korea' && fixture['league']['name'] == 'K-League Classic'){
          fixture['popularity'] = '473';
        } */else if(fixture['league']['country'] == 'Spain' && fixture['league']['name'] == 'Segunda Division'){
          fixture['popularity'] = '474';
        } else if(fixture['league']['country'] == 'Spain' && fixture['league']['name'] == 'Segunda B - Group 1'){
          fixture['popularity'] = '475';
        } else if(fixture['league']['country'] == 'Spain' && fixture['league']['name'] == 'Segunda B - Group 2'){
          fixture['popularity'] = '476';
        } else if(fixture['league']['country'] == 'Spain' && fixture['league']['name'] == 'Segunda B - Group 3'){
          fixture['popularity'] = '477';
        } else if(fixture['league']['country'] == 'Spain' && fixture['league']['name'] == 'Segunda B - Group 4'){
          fixture['popularity'] = '478';
        } /*else if(fixture['league']['country'] == 'Spain' && fixture['league']['name'] == 'Tercera Division - Group 1'){
          fixture['popularity'] = '479';
        } else if(fixture['league']['country'] == 'Spain' && fixture['league']['name'] == 'Tercera Division - Group 2'){
          fixture['popularity'] = '480';
        } else if(fixture['league']['country'] == 'Spain' && fixture['league']['name'] == 'Tercera Division - Group 3'){
          fixture['popularity'] = '481';
        } else if(fixture['league']['country'] == 'Spain' && fixture['league']['name'] == 'Tercera Division - Group 4'){
          fixture['popularity'] = '482';
        } else if(fixture['league']['country'] == 'Spain' && fixture['league']['name'] == 'Tercera Division - Group 5'){
          fixture['popularity'] = '483';
        } else if(fixture['league']['country'] == 'Spain' && fixture['league']['name'] == 'Tercera Division - Group 6'){
          fixture['popularity'] = '484';
        } else if(fixture['league']['country'] == 'Spain' && fixture['league']['name'] == 'Tercera Division - Group 7'){
          fixture['popularity'] = '485';
        } else if(fixture['league']['country'] == 'Spain' && fixture['league']['name'] == 'Tercera Division - Group 8'){
          fixture['popularity'] = '486';
        } else if(fixture['league']['country'] == 'Spain' && fixture['league']['name'] == 'Tercera Division - Group 9'){
          fixture['popularity'] = '487';
        } else if(fixture['league']['country'] == 'Spain' && fixture['league']['name'] == 'Tercera Division - Group 10'){
          fixture['popularity'] = '488';
        } else if(fixture['league']['country'] == 'Spain' && fixture['league']['name'] == 'Tercera Division - Group 11'){
          fixture['popularity'] = '489';
        } else if(fixture['league']['country'] == 'Spain' && fixture['league']['name'] == 'Tercera Division - Group 12'){
          fixture['popularity'] = '490';
        } else if(fixture['league']['country'] == 'Spain' && fixture['league']['name'] == 'Tercera Division - Group 13'){
          fixture['popularity'] = '491';
        } else if(fixture['league']['country'] == 'Spain' && fixture['league']['name'] == 'Tercera Division - Group 14'){
          fixture['popularity'] = '492';
        } else if(fixture['league']['country'] == 'Spain' && fixture['league']['name'] == 'Tercera Division - Group 15'){
          fixture['popularity'] = '493';
        } else if(fixture['league']['country'] == 'Spain' && fixture['league']['name'] == 'Tercera Division - Group 16'){
          fixture['popularity'] = '494';
        } else if(fixture['league']['country'] == 'Spain' && fixture['league']['name'] == 'Tercera Division - Group 17'){
          fixture['popularity'] = '495';
        } else if(fixture['league']['country'] == 'Spain' && fixture['league']['name'] == 'Tercera Division - Group 18'){
          fixture['popularity'] = '496';
        }*/
        else if(fixture['league']['country'] == 'Sudan' && fixture['league']['name'] == 'Sudani Premier League'){
          fixture['popularity'] = '479';
        } else if(fixture['league']['country'] == 'Sweden' && fixture['league']['name'] == 'Allsvenskan'){
          fixture['popularity'] = '480';
        } else if(fixture['league']['country'] == 'Sweden' && fixture['league']['name'] == 'Superettan'){
          fixture['popularity'] = '481';
        } else if(fixture['league']['country'] == 'Sweden' && fixture['league']['name'] == 'Svenska Cupen'){
          fixture['popularity'] = '482';
        } else if(fixture['league']['country'] == 'Switzerland' && fixture['league']['name'] == 'Super League'){
          fixture['popularity'] = '483';
        } else if(fixture['league']['country'] == 'Switzerland' && fixture['league']['name'] == 'Challenge League'){
          fixture['popularity'] = '484';
        } else if(fixture['league']['country'] == 'Switzerland' && fixture['league']['name'] == 'Schweizer Pokal'){
          fixture['popularity'] = '485';
        } else if(fixture['league']['country'] == 'Syria' && fixture['league']['name'] == 'Premier League'){
          fixture['popularity'] = '486';
        } else if(fixture['league']['country'] == 'Tajikistan' && fixture['league']['name'] == 'Vysshaya Liga'){
          fixture['popularity'] = '487';
        } else if(fixture['league']['country'] == 'Tanzania' && fixture['league']['name'] == 'Ligi kuu Bara'){
          fixture['popularity'] = '488';
        } else if(fixture['league']['country'] == 'Thailand' && fixture['league']['name'] == 'FA Cup'){
          fixture['popularity'] = '489';
        } else if(fixture['league']['country'] == 'Thailand' && fixture['league']['name'] == 'Thai Premier League'){
          fixture['popularity'] = '490';
        } else if(fixture['league']['country'] == 'Tunisia' && fixture['league']['name'] == 'Cup'){
          fixture['popularity'] = '491';
        } else if(fixture['league']['country'] == 'Tunisia' && fixture['league']['name'] == 'Ligue Professionnelle 1'){
          fixture['popularity'] = '492';
        } else if(fixture['league']['country'] == 'Turkey' && fixture['league']['name'] == 'Super Lig'){
          fixture['popularity'] = '493';
        } else if(fixture['league']['country'] == 'Turkey' && fixture['league']['name'] == 'Super Cup'){
          fixture['popularity'] = '494';
        } else if(fixture['league']['country'] == 'Turkey' && fixture['league']['name'] == 'Cup'){
          fixture['popularity'] = '495';
        } else if(fixture['league']['country'] == 'Turkmenistan' && fixture['league']['name'] == 'Yokary Liga'){
          fixture['popularity'] = '496';
        } else if(fixture['league']['country'] == 'USA' && fixture['league']['name'] == 'US Open Cup'){
          fixture['popularity'] = '497';
        } else if(fixture['league']['country'] == 'USA' && fixture['league']['name'] == 'USL League One'){
          fixture['popularity'] = '498';
        } else if(fixture['league']['country'] == 'USA' && fixture['league']['name'] == 'Major League Soccer'){
          fixture['popularity'] = '499';
        } else if(fixture['league']['country'] == 'USA' && fixture['league']['name'] == 'USL Championship'){
          fixture['popularity'] = '500';
        } else if(fixture['league']['country'] == 'USA' && fixture['league']['name'] == 'NISA USA'){
          fixture['popularity'] = '501';
        } else if(fixture['league']['country'] == 'Uganda' && fixture['league']['name'] == 'Premier League'){
          fixture['popularity'] = '502';
        } else if(fixture['league']['country'] == 'Ukraine' && fixture['league']['name'] == 'Super Cup'){
          fixture['popularity'] = '503';
        } else if(fixture['league']['country'] == 'Ukraine' && fixture['league']['name'] == 'Cup'){
          fixture['popularity'] = '504';
        } else if(fixture['league']['country'] == 'Ukraine' && fixture['league']['name'] == 'Persha Liga'){
          fixture['popularity'] = '505';
        } else if(fixture['league']['country'] == 'Ukraine' && fixture['league']['name'] == 'Premier League'){
          fixture['popularity'] = '506';
        } else if(fixture['league']['country'] == 'United-Arab-Emirates' && fixture['league']['name'] == 'Presidents Cup'){
          fixture['popularity'] = '507';
        } else if(fixture['league']['country'] == 'United-Arab-Emirates' && fixture['league']['name'] == 'Division 1'){
          fixture['popularity'] = '508';
        } else if(fixture['league']['country'] == 'United-Arab-Emirates' && fixture['league']['name'] == 'Arabian Gulf League'){
          fixture['popularity'] = '509';
        } else if(fixture['league']['country'] == 'United-Arab-Emirates' && fixture['league']['name'] == 'League Cup'){
          fixture['popularity'] = '510';
        } else if(fixture['league']['country'] == 'Uruguay' && fixture['league']['name'] == 'Primera Division - Apertura'){
          fixture['popularity'] = '511';
        } else if(fixture['league']['country'] == 'Uruguay' && fixture['league']['name'] == 'Primera Division - Clausura'){
          fixture['popularity'] = '512';
        } else if(fixture['league']['country'] == 'Uzbekistan' && fixture['league']['name'] == 'Super League'){
          fixture['popularity'] = '513';
        } else if(fixture['league']['country'] == 'Uzbekistan' && fixture['league']['name'] == 'Super Cup'){
          fixture['popularity'] = '514';
        } else if(fixture['league']['country'] == 'Uzbekistan' && fixture['league']['name'] == 'Cup'){
          fixture['popularity'] = '515';
        } else if(fixture['league']['country'] == 'Venezuela' && fixture['league']['name'] == 'Primera Division'){
          fixture['popularity'] = '516';
        } else if(fixture['league']['country'] == 'Vietnam' && fixture['league']['name'] == 'Cup'){
          fixture['popularity'] = '517';
        } else if(fixture['league']['country'] == 'Vietnam' && fixture['league']['name'] == 'V.League 1'){
          fixture['popularity'] = '518';
        } else if(fixture['league']['country'] == 'Wales' && fixture['league']['name'] == 'League Cup'){
          fixture['popularity'] = '519';
        } else if(fixture['league']['country'] == 'Wales' && fixture['league']['name'] == 'Premier'){
          fixture['popularity'] = '520';
        } else if(fixture['league']['country'] == 'Zambia' && fixture['league']['name'] == 'Super League'){
          fixture['popularity'] = '521';
        } 
        else {
          fixture['popularity'] = '600';

        } 


      _date.sink.add(date);
      _fixtures.sink.add(data);

      
      
     
      
      
      
      

      });

    
    
    
  }

   

  



}}