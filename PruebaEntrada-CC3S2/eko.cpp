#include <bits/stdc++.h>

using namespace std;

typedef long long ll;

void solve(int n, int m, ll arr[])
{
    sort(arr, arr + n, greater<int>());

    int ans = arr[0] - 1;

    while (ans > 0)
    {
        int wood = 0;

        for (int i = 0; i < n; i++)
        {
            if (arr[i] <= ans)
                break;

            wood += arr[i] - ans;
        }

        if (wood >= m)
        {
            cout << ans;
            return;
        }
        ans--;
    }
}


int main()
{
    ios::sync_with_stdio(false);
    cin.tie(nullptr);

    int n, m;
    cin >> n >> m;

    ll arr[n];
    for (int i = 0; i < n; i++) cin >> arr[i];

    solve(n, m, arr);

    return 0;
}
