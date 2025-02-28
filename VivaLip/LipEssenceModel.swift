//
//  LipEssenceModel.swift
//  VivaLip
//
//  Created by VivaLip on 2024/12/30.
//

import ObjectMapper

struct LipEssenceModel: Mappable {
    var lipGlossShade: String = ""
    var beautyRoutineTip: String = ""
    var vivaIconStyle: String = ""
    var glamourTrendID: String = ""
    var lipstickMixerName: String = ""
    var shadeCreatorID: String = ""
    var glamCreatorNote: String = ""
    var glamNoteAddTime: String = ""
    var lipCharmCounter: Int = 0
    var vivaCaptureMoments: [String] = []
    
    var botFavoriteNumber: Int = Int.random(in: 10...20)
    var vlSubscribers: Int = Int.random(in: 5...20)
    var vlInfluencers: Int = Int.random(in: 5...20)
    var vllipFriends: Int = Int.random(in: 5...20)
    var vlCreateTime: Double = 0.0
    
    init?(map: Map) {
        
    }
    
    init(lipGlossShade: String = "",
         beautyRoutineTip: String = "",
         vivaIconStyle: String = "",
         glamourTrendID: String = "") {
        self.lipGlossShade = lipGlossShade
        self.beautyRoutineTip = beautyRoutineTip
        self.vivaIconStyle = vivaIconStyle
        self.glamourTrendID = glamourTrendID
    }
    
    init(){}
    
    mutating func mapping(map: Map) {
        lipGlossShade       <- map["lipGlossShade"]
        beautyRoutineTip    <- map["beautyRoutineTip"]
        vivaIconStyle       <- map["vivaIconStyle"]
        glamourTrendID      <- map["glamourTrendID"]
        lipstickMixerName   <- map["lipstickMixerName"]
        shadeCreatorID      <- map["shadeCreatorID"]
        glamCreatorNote     <- map["glamCreatorNote"]
        glamNoteAddTime     <- map["glamNoteAddTime"]
        lipCharmCounter     <- map["lipCharmCounter"]
        vivaCaptureMoments  <- map["vivaCaptureMoments"]
        botFavoriteNumber   <- map["botFavoriteNumber"]
        vlCreateTime        <- map["vlCreateTime"]
        vlSubscribers       <- map["vlSubscribers"]
        vlInfluencers       <- map["vlInfluencers"]
        vllipFriends       <- map["vllipFriends"]
    }
}
