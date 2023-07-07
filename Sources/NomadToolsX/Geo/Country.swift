//
//  Country.swift
//  NomadTools
//
//  Created by Justin Ackermann on 8/13/21.
//

import UIKit

public enum Country: String, Codable {
    case Afghanistan, Albania, Algeria, Andorra, Angola, Antigua_And_Barbuda, Argentina, Armenia, Australia, Austria, Azerbaijan, Bahamas, Bahrain, Bangladesh, Barbados, Belarus, Belgium, Belize, Benin, Bhutan, Bolivia, Bosnia_And_Herzegovina, Botswana, Brazil, Brunei, Bulgaria, Burkina_Faso, Burundi, Cote_dIvoire, Cabo_Verde, Cambodia, Cameroon, Canada, Central_African_Republic, Chad, Chile, China, Colombia, Comoros, Congo, Costa_Rica, Croatia, Cuba, Cyprus, Czech_Republic, Democratic_Republic_of_the_Congo, Denmark, Djibouti, Dominica, Dominican_Republic, Ecuador, Egypt, El_Salvador, Equatorial_Guinea, Eritrea, Estonia, Eswatini, Ethiopia, Fiji, Finland, France, Gabon, Gambia, Georgia, Germany, Ghana, Greece, Grenada, Guatemala, Guinea, Guinea_Bissau, Guyana, Haiti, Holy_See, Honduras, Hungary, Iceland, India, Indonesia, Iran, Iraq, Ireland, Israel, Italy, Jamaica, Japan, Jordan, Kazakhstan, Kenya, Kiribati, Kuwait, Kyrgyzstan, Laos, Latvia, Lebanon, Lesotho, Liberia, Libya, Liechtenstein, Lithuania, Luxembourg, Madagascar, Malawi, Malaysia, Maldives, Mali, Malta, Marshall_Islands, Mauritania, Mauritius, Mexico, Micronesia, Moldova, Monaco, Mongolia, Montenegro, Morocco, Mozambique, Myanmar, Namibia, Nauru, Nepal, Netherlands, New_Zealand, Nicaragua, Niger, Nigeria, North_Korea, North_Macedonia, Norway, Oman, Pakistan, Palau, Palestine_State, Panama, Papua_New_Guinea, Paraguay, Peru, Philippines, Poland, Portugal, Qatar, Romania, Russia, Rwanda, Saint_Kitts_And_Nevis, Saint_Lucia, Saint_Vincent_And_the_Grenadines, Samoa, San_Marino, Sao_Tome_And_Principe, Saudi_Arabia, Senegal, Serbia, Seychelles, Sierra_Leone, Singapore, Slovakia, Slovenia, Solomon_Islands, Somalia, South_Africa, South_Korea, South_Sudan, Spain, Sri_Lanka, Sudan, Suriname, Sweden, Switzerland, Syria, Tajikistan, Tanzania, Thailand, Timor_Leste, Togo, Tonga, Trinidad_And_Tobago, Tunisia, Turkey, Turkmenistan, Tuvalu, Uganda, Ukraine, United_Arab_Emirates, United_Kingdom, United_States, Uruguay, Uzbekistan, Vanuatu, Venezuela, Vietnam, Yemen, Zambia, Zimbabwe
    
    public init?(country: String)
    { self.init(rawValue: country.replacingOccurrences(of: " ", with: "_")) }
    
    public var name: String {
        return self.rawValue
            .replacingOccurrences(of: "_", with: " ")
    }
    
    internal var processed: String {
        return self.rawValue
            .replacingOccurrences(of: "_", with: "-")
            .lowercased()
    }
    
//    public var roundIcon: UIImage? {
//        Image.named(
//            "\(processed)_round"
//        ).image
//    }
//
//    public var squareIcon: UIImage? {
//        Image.named(
//            "\(processed)_square"
//        ).image
//    }
//
//    public var rectIcon: UIImage? {
//        Image.named(
//            "\(processed)_rect"
//        ).image
//    }
    
    // TODO: Finish (https://countrycode.org)
    enum CountryCode: String, Codable {
        case AF,AL,DZ,AD,AO,AI,AQ,AG,AR,AM,AW,AU,AT,AZ,BS,BH,BD,BB,BY,BE,BZ,BJ,BM,BT,BO,BA,BW,BV,BR,IO,BN,BG,BF,BI,KH,CM,CA,CV,KY,CF,TD,CL,CN,CX,CC,CO,KM,CG,CD,CK,CR,CI,HR,CU,CY,CZ,DK,DJ,DM,DO,EC,EG,SV,GQ,ER,EE,ET,FK,FO,FJ,FI,FR,GF,PF,TF,GA,GM,GE,DE,GH,GI,GR,GL,GD,GP,GU,GT,GN,GW,GY,HT,HM,VA,HN,HK,HU,IS,IN,ID,IR,IQ,IE,IL,IT,JM,JP,JO,KZ,KE,KI,KP,KR,KW,KG,LA,LV,LB,LS,LR,LY,LI,LT,LU,MO,MK,MG,MW,MY,MV,ML,MT,MH,MQ,MR,MU,YT,MX,FM,MD,MC,MN,MS,MA,MZ,MM,NA,NR,NP,NL,AN,NC,NZ,NI,NE,NG,NU,NF,MP,NO,OM,PK,PW,PS,PA,PG,PY,PE,PH,PN,PL,PT,PR,QA,RE,RO,RU,RW,SH,KN,LC,PM,VC,WS,SM,ST,SA,SN,SC,SL,SG,SK,SI,SB,SO,ZA,GS,ES,LK,SD,SR,SJ,SZ,SE,CH,SY,TW,TJ,TZ,TH,TG,TK,TO,TT,TN,TR,TM,TC,TV,UG,UA,AE,GB,US,UM,UY,UZ,VU,VE,VN,VG,VI,WF,EH,YE,ZM,ZW
    }
}
