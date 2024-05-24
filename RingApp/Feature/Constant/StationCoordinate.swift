//
//  StationCoordinate.swift
//  RingApp
//
//  Created by Emre on 14.04.2024.
//

import MapKit
final class StationCoordinate{
    static let coordinates: [Station] = [
        Station(title:"1.Durak" , subtitle: "Kalkış-Varış Durağı", coordinate: CLLocationCoordinate2D(latitude: 37.16586167202024, longitude: 38.99618142474569), near: "90 durağı ve A101 marketin yanı başında"),
        Station(title:"2.Durak" , subtitle: "Yüzme Havuzu Durağı", coordinate: CLLocationCoordinate2D(latitude: 37.16630811088499, longitude: 38.99775277608713), near: "Yüzme havuzunun karşısında"),
        Station(title: "3.Durak", subtitle: "Eğitim Fakültesi Durağı", coordinate: CLLocationCoordinate2D(latitude: 37.16755168242994, longitude: 39.001763565370084), near: "Eğitim Fakültesinin karşısı"),
        Station(title: "4.Durak", subtitle: "Devlet Konservatuar Durağı", coordinate: CLLocationCoordinate2D(latitude: 37.16823699237787, longitude: 39.00283023736826), near: "Devlet Konservatuar karşısı"),
        Station(title: "5.Durak", subtitle: "BESYO Durağı", coordinate: CLLocationCoordinate2D(latitude: 37.171026468594555, longitude: 39.00517814888009), near: "Mühendislik fakültesi ve BESYO karşısı"),
        Station(title: "6.Durak", subtitle: "İİBF Durağı", coordinate: CLLocationCoordinate2D(latitude: 37.17351858530618, longitude: 39.00189170114116),near:  "Mühendislik fakültesi ve İİBF karşısı"),
        Station(title: "7.Durak", subtitle: "Hacer Ana Kız Yurdu Durağı", coordinate: CLLocationCoordinate2D(latitude: 37.17435824962693, longitude: 38.99877685898203),near: "Hacer Ana Kız Yurdu Karşısı"),
        Station(title: "8.Durak", subtitle: "Harran Kız Yurdu Durağı", coordinate: CLLocationCoordinate2D(latitude: 37.17515536285534, longitude: 38.99691507249199), near: "Harran Kız Yurdu Karşısı"),
        Station(title: "9.Durak", subtitle: "Göbeklitepe Erkek Yurdu Durağı", coordinate: CLLocationCoordinate2D(latitude: 37.17735326513586, longitude: 38.99572918004911), near: "Göbeklitepe Erkek Yurdu Yanı"),
        Station(title: "10.Durak", subtitle: "Üniversite Cami Durağı", coordinate: CLLocationCoordinate2D(latitude: 37.175414019440055, longitude: 38.99544128991743), near: "Üniversite Cami Yanı"),
        Station(title: "11.Durak", subtitle: "Göl Durağı", coordinate: CLLocationCoordinate2D(latitude: 37.17121916241424, longitude: 38.99627597497785), near: "Göl ve Merkezi Yemekhanye yakını"),
        Station(title: "12.Durak", subtitle: "TIP Durağı", coordinate: CLLocationCoordinate2D(latitude: 37.16880202104119, longitude: 38.99495270003612), near: "TIP ve kütüphane yakını")
    ]
}

