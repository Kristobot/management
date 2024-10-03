# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Management.Repo.insert!(%Management.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.


alias Management.Profile.District
alias Management.Repo
alias Management.Account.Role


Repo.insert(%Role{name: "admin"})
Repo.insert(%Role{name: "user"})

Repo.insert(%District{name: "Chorrillos"})
