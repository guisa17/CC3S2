#include <bits/stdc++.h>

using namespace std;

typedef vector<pair<int, pair<int, int>>> coords;

void solve(int n, coords &p)
{
    sort(p.begin(), p.end());

    int ans = 2 * p[0].first;

    for (int i = 1; i < n; i++)
    {
        int y = p[i].first;
        int x1 = p[i].second.first;
        int x2 = p[i].second.second;

        bool flag1 = false, flag2 = false;

        for (int j = i - 1; j >= 0; j--)
        {
            int y_ = p[j].first;
            int x1_ = p[j].second.first;
            int x2_ = p[j].second.second;

            if (!flag1 && x1 > x1_ && x1 < x2_)
            {
                ans += y - y_;
                flag1 = true;
            }
            if (!flag2 && x2 > x1_ && x2 < x2_)
            {
                ans += y - y_;
                flag2 = true;
            }
        }
        if (!flag1) ans += y;
        if (!flag2) ans += y;
    }
    cout << ans;
}


int main()
{
    ios::sync_with_stdio(false);
    cin.tie(nullptr);

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
