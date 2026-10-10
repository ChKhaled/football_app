package stat

type Stat struct {
	ID int64
	PlayerMatchTeam int64
	
	Goals        int
	Assists      int
	KmCovered float32
	Shots        int
	Passes       int
	Tackles      int
	Interceptions int
	Recoveries   int
	Saves        int
	Dribbles      int
	Fouls  int
}