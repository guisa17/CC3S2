#include <bits/stdc++.h>

using namespace std;

typedef vector<pair<int, pair<int, int>>> coords;


void solve(int n, const coords &pltf)
{
    int ans = 0;

    for (const auto& p : pltf)
    {
        int y = p.first;
        int x1 = p.second.first;
        int x2 = p.second.second;

        // TODO
    }

}


int main()
{
    int n;
    cin >> n;
    coords platforms;

    for (int i = 0; i < n; i++)
    {
        int y, x1, x2;
        cin >> y >> x1 >> x2;
        platforms.push_back({y, {x1, x2}});
    }

    solve(n, platforms);

    return 0;
}
