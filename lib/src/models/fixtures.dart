// To parse this JSON data, do
//
//     final fixtures = fixturesFromJson(jsonString);

import 'dart:convert';


Fixtures fixturesFromJson(String str) => Fixtures.fromJson(json.decode(str));

String fixturesToJson(Fixtures data) => json.encode(data.toJson());

class Fixtures {
    Fixtures({
        this.api,
    });

    Api api;

    factory Fixtures.fromJson(Map<String, dynamic> json) => Fixtures(
        api: Api.fromJson(json["api"]),
    );

    Map<String, dynamic> toJson() => {
        "api": api.toJson(),
    };
}

class Api {
    Api({
        this.results,
        this.fixtures,
    });

    int results;
    List<Fixture> fixtures;

    factory Api.fromJson(Map<String, dynamic> json) => Api(
        results: json["results"],
        fixtures: List<Fixture>.from(json["fixtures"].map((x) => Fixture.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "results": results,
        "fixtures": List<dynamic>.from(fixtures.map((x) => x.toJson())),
    };
}

class Fixture {
    Fixture({
        this.fixtureId,
        this.leagueId,
        this.league,
        this.eventDate,
        this.eventTimestamp,
        this.firstHalfStart,
        this.secondHalfStart,
        this.round,
        this.status,
        this.statusShort,
        this.elapsed,
        this.venue,
        this.referee,
        this.homeTeam,
        this.awayTeam,
        this.goalsHomeTeam,
        this.goalsAwayTeam,
        this.score,
    });

    int fixtureId;
    int leagueId;
    League league;
    DateTime eventDate;
    int eventTimestamp;
    int firstHalfStart;
    int secondHalfStart;
    String round;
    String status;
    String statusShort;
    int elapsed;
    String venue;
    dynamic referee;
    Team homeTeam;
    Team awayTeam;
    int goalsHomeTeam;
    int goalsAwayTeam;
    Score score;

    factory Fixture.fromJson(Map<String, dynamic> json) => Fixture(
        fixtureId: json["fixture_id"],
        leagueId: json["league_id"],
        league: League.fromJson(json["league"]),
        eventDate: DateTime.parse(json["event_date"]),
        eventTimestamp: json["event_timestamp"],
        firstHalfStart: json["firstHalfStart"],
        secondHalfStart: json["secondHalfStart"],
        round: json["round"],
        status: json["status"],
        statusShort: json["statusShort"],
        elapsed: json["elapsed"],
        venue: json["venue"],
        referee: json["referee"],
        homeTeam: Team.fromJson(json["homeTeam"]),
        awayTeam: Team.fromJson(json["awayTeam"]),
        goalsHomeTeam: json["goalsHomeTeam"],
        goalsAwayTeam: json["goalsAwayTeam"],
        score: Score.fromJson(json["score"]),
    );

    Map<String, dynamic> toJson() => {
        "fixture_id": fixtureId,
        "league_id": leagueId,
        "league": league.toJson(),
        "event_date": eventDate.toIso8601String(),
        "event_timestamp": eventTimestamp,
        "firstHalfStart": firstHalfStart,
        "secondHalfStart": secondHalfStart,
        "round": round,
        "status": status,
        "statusShort": statusShort,
        "elapsed": elapsed,
        "venue": venue,
        "referee": referee,
        "homeTeam": homeTeam.toJson(),
        "awayTeam": awayTeam.toJson(),
        "goalsHomeTeam": goalsHomeTeam,
        "goalsAwayTeam": goalsAwayTeam,
        "score": score.toJson(),
    };
}

class Team {
    Team({
        this.teamId,
        this.teamName,
        this.logo,
    });

    int teamId;
    String teamName;
    String logo;

    factory Team.fromJson(Map<String, dynamic> json) => Team(
        teamId: json["team_id"],
        teamName: json["team_name"],
        logo: json["logo"],
    );

    Map<String, dynamic> toJson() => {
        "team_id": teamId,
        "team_name": teamName,
        "logo": logo,
    };
}

class League {
    League({
        this.name,
        this.country,
        this.logo,
        this.flag,
    });

    String name;
    String country;
    String logo;
    String flag;

    factory League.fromJson(Map<String, dynamic> json) => League(
        name: json["name"],
        country: json["country"],
        logo: json["logo"],
        flag: json["flag"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "country": country,
        "logo": logo,
        "flag": flag,
    };
}

class Score {
    Score({
        this.halftime,
        this.fulltime,
        this.extratime,
        this.penalty,
    });

    String halftime;
    String fulltime;
    dynamic extratime;
    dynamic penalty;

    factory Score.fromJson(Map<String, dynamic> json) => Score(
        halftime: json["halftime"],
        fulltime: json["fulltime"],
        extratime: json["extratime"],
        penalty: json["penalty"],
    );

    Map<String, dynamic> toJson() => {
        "halftime": halftime,
        "fulltime": fulltime,
        "extratime": extratime,
        "penalty": penalty,
    };
}
