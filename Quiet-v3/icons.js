// Original Quiet line drawings. No remote assets or audio/account requests.
export const drawings = {
  musicVideo: '<rect x="2" y="4" width="20" height="15" rx="3"/><path d="m10 8 6 3.5-6 3.5Z M8 22h8"/>',
  record: '<circle cx="12" cy="12" r="9"/><circle cx="12" cy="12" r="3"/><path d="M5.7 10a7 7 0 0 1 4.3-4.3M14 18.3a7 7 0 0 0 4.3-4.3"/>',
  piano: '<rect x="3" y="5" width="18" height="14" rx="2"/><path d="M7.5 12v7M12 12v7M16.5 12v7M7.5 5v7M12 5v7M16.5 5v7"/><path stroke-width="3" d="M7.5 6v5M12 6v5M16.5 6v5"/>',
  strings: '<path d="m14 3 3 1-4 11M15 3l1-2M15 8c4 0 5 3 2 5 3 5-1 9-6 7s-5-6-1-8c-2-3 0-6 3-5M9 16l5 2M21 4 14 22"/>',
  guitar: '<path d="m14 9 5-6 2 2-6 6c2 4-1 5-2 5-1 5-5 6-8 3s-2-7 3-8c0-1 2-4 6-2Z"/><circle cx="10" cy="14" r="2"/><path d="m6 17 2 2M19 2l3 3"/>',
  drums: '<ellipse cx="12" cy="11" rx="8" ry="3"/><path d="M4 11v7c0 4 16 4 16 0v-7M8 14v6M16 14v6M4 3l12 4M20 2 9 7"/>',
  sax: '<path d="M10 3h5v11c0 7-8 8-10 3l-2-5 5-2 1 5c1 2 3 1 3-1V5h-2M10 3 8 2"/><path d="M16 7h2M16 10h2M7 11l-3 1"/>',
  trumpet: '<path d="M3 10h11l7-4v13l-7-4H8c-4 0-4-5 0-5M3 8v5M9 7v3M12 7v3M8 7h2M11 7h2M8 15v3h7v-5"/>',
  mic: '<rect x="9" y="2" width="6" height="13" rx="3"/><path d="M6 10v2a6 6 0 0 0 12 0v-2M12 18v4M8 22h8M10 6h4M10 9h4"/>',
  synth: '<rect x="2" y="6" width="20" height="14" rx="2"/><path d="M2 12h20M7 12v8M12 12v8M17 12v8M6 9h1M10 9h1M16 9h2M7 3v3M17 3v3"/>',
  wave: '<path d="M2 12h3l2-7 4 15 3-17 3 14 2-5h3"/>',
  headphones: '<path d="M3 13v-2a9 9 0 0 1 18 0v2M5 12H3v8h4v-8Zm14 0h2v8h-4v-8Z"/>',
  star: '<path d="m12 2 2.8 6.2L22 9l-5.4 4.8 1.6 7-6.2-3.6L5.8 21l1.6-7L2 9l7.2-.8Z"/>',
  heart: '<path d="M20 5c-3-3-7-1-8 1-1-2-5-4-8-1-5 5 2 11 8 16 6-5 13-11 8-16Z"/>',
  moon: '<path d="M20 15A9 9 0 0 1 9 3a9 9 0 1 0 11 12Z"/><path d="M17 3v4M15 5h4"/>',
  radio: '<rect x="3" y="8" width="18" height="13" rx="2"/><path d="m5 8 13-6M14 12h4M14 16h1M18 16h1"/><circle cx="8" cy="15" r="3"/>',
  chart: '<path d="M4 21V11M10 21V7M16 21V3M22 21H2"/>',
  film: '<rect x="3" y="3" width="18" height="18" rx="2"/><path d="M7 3v18M17 3v18M3 8h4M3 16h4M17 8h4M17 16h4M10 9l5 3-5 3Z"/>',
  book: '<path d="M12 5C8 2 4 3 2 4v16c4-2 7-1 10 1 3-2 6-3 10-1V4c-2-1-6-2-10 1Zm0 0v16"/>',
  person: '<circle cx="12" cy="7" r="4"/><path d="M4 22v-3a8 8 0 0 1 16 0v3"/>',
};
const rules = [
  [/\b(liked songs|favorites|favourites)\b/i, 'Favorites', ['heart']],
  [/\b(podcast|episodes?)\b/i, 'Spoken word', ['mic']],
  [/\b(audiobooks?)\b/i, 'Audiobook', ['book']],
  [/\b(classical|orchestra|symphon\w*|concerto|chamber|baroque|mozart|beethoven|bach|paganini|vivaldi|chopin|debussy|tchaikovsky)\b/i, 'Classical', ['strings','piano']],
  [/\b(jazz|bebop|swing)\b/i, 'Jazz', ['sax','piano']],
  [/\b(rock|metal|punk|grunge)\b/i, 'Rock', ['guitar','drums']],
  [/\b(hip[ -]?hop|rap|trap)\b/i, 'Hip-hop', ['mic','drums']],
  [/\b(electronic|edm|techno|house|trance|synth\w*|dubstep)\b/i, 'Electronic', ['synth','wave']],
  [/\b(country|bluegrass|folk|acoustic)\b/i, 'Acoustic / folk', ['guitar']],
  [/\b(blues)\b/i, 'Blues', ['guitar','mic']],
  [/\b(soul|r\s*&\s*b|rnb|gospel)\b/i, 'Soul / R&B', ['mic','piano']],
  [/\b(reggae|ska|dub)\b/i, 'Reggae', ['guitar','drums']],
  [/\b(latin|salsa|bossa|samba|reggaeton)\b/i, 'Latin', ['drums','trumpet']],
  [/\b(ambient|meditation|sleep|calm|focus)\b/i, 'Quiet listening', ['moon','wave']],
  [/\b(soundtrack|cinema|film|musical)\b/i, 'Soundtrack', ['film']],
  [/\b(pop|k[ -]?pop|party|dance|disco)\b/i, 'Pop / dance', ['star','mic']],
  [/\b(top\s*\d+|charts?|billboard)\b/i, 'Charts', ['chart']],
  [/\b(19[5-9]0s?|[5-9]0s|oldies|sixties|seventies|eighties)\b/i, 'Decades', ['record','radio']],
  [/\bradio\b/i, 'Radio', ['radio']],
];
const instruments = [
  [/\b(piano|pianist|keyboard)\b/i,'piano'], [/\b(violin|viola|cello|strings|quartet)\b/i,'strings'],
  [/\b(guitar|banjo|ukulele)\b/i,'guitar'], [/\b(drums?|percussion)\b/i,'drums'],
  [/\b(sax|saxophone)\b/i,'sax'], [/\b(trumpet|brass)\b/i,'trumpet'],
  [/\b(vocals?|choir|choral|a cappella)\b/i,'mic'], [/\b(synth|synthesizer)\b/i,'synth'],
];
export function classify(text = '', mediaType = 'audio') {
  if(mediaType === 'video') return {label:'Music video',icons:['musicVideo'],basis:'Spotify identifies this as a video'};
  const explicit = instruments.filter(([re]) => re.test(text)).map(([,id]) => id);
  if (explicit.length) return {label:'Instrument cues',icons:explicit.slice(0,3),basis:'Instruments named in the title'};
  const rule = rules.find(([re]) => re.test(text));
  return rule ? {label:rule[1],icons:rule[2],basis:'Genre symbol inferred from the title; not audio analysis'} : {label:'Music',icons:['record'],basis:'Neutral music symbol; genre unknown'};
}
export function svg(id) {
  return `<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.55" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">${drawings[id] || drawings.record}</svg>`;
}
function titleFor(img) {
  if (img.alt?.trim()) return img.alt.trim();
  const card=img.closest('[data-encore-id="card"]');
  if(card) return card.querySelector('.main-card-cardTitle')?.textContent?.trim() || '';
  let el=img.parentElement;
  for(let depth=0;el && depth<6;depth++,el=el.parentElement) {
    const text=[...el.childNodes].filter(n=>!n.classList?.contains('quiet-symbol')).map(n=>n.textContent).join(' ').trim();
    if(text && text.length<450) return text;
    const label=el.getAttribute('aria-label');
    if(label) return label;
  }
  return '';
}
export function load() {
  const mounted=new Map(); let frame=0; let disposed=false;
  const observer=new MutationObserver(()=>{ if(!frame) frame=requestAnimationFrame(scan); });
  function scan() {
    frame=0; if(disposed)return; observer.disconnect();
    try {
      for(const [host,data] of mounted) if(!host.isConnected || !host.contains(data.img)) {data.badge.remove();host.classList.remove('quiet-symbol-host');mounted.delete(host);}
      for(const img of document.querySelectorAll('.Root img')) {
        const host=img.parentElement;
        if(!host || /BUTTON|PICTURE/.test(host.tagName) || img.closest('[data-testid="user-widget-avatar"]'))continue;
        const box=host.getBoundingClientRect();
        if(box.width<28 || box.height<28 || box.width>box.height*2)continue;
        const cue=classify(titleFor(img),img.matches('[data-testid="video-card-image"]') ? 'video' : 'audio');
        const key=JSON.stringify(cue); let data=mounted.get(host);
        if(data?.key===key && data.badge.isConnected) continue;
        if(data)data.badge.remove();
        const badge=document.createElement('span');
        badge.className='quiet-symbol';badge.setAttribute('role','img');
        badge.setAttribute('aria-label',`${cue.label}: ${cue.icons.join(', ')}. ${cue.basis}`);
        badge.title=badge.getAttribute('aria-label');
        // Only constant artwork/labels from this file enter markup. Spotify text never does.
        badge.innerHTML=`<span class="quiet-symbol-instruments">${cue.icons.map(svg).join('')}</span>`;
        host.classList.add('quiet-symbol-host');host.append(badge);
        mounted.set(host,{img,badge,key});
      }
    } finally {if(!disposed)observer.observe(document.body,{subtree:true,childList:true,characterData:true,attributes:true,attributeFilter:['alt','src','data-testid']});}
  }
  scan();
  return ()=>{disposed=true;observer.disconnect();cancelAnimationFrame(frame);for(const [host,{badge}] of mounted){badge.remove();host.classList.remove('quiet-symbol-host');}mounted.clear();};
}
